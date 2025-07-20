{
  nixpkgs ? <nixpkgs>,
  pkgs ? import nixpkgs { inherit system; },
  system ? builtins.currentSystem,
  flake,
  ...
}:
pkgs.nixosTest {
  name = "riptide-integration";
  nodes.system1 =
    {
      config,
      pkgs,
      options,
      ...
    }:
    {
      imports = [ flake.nixosModules.riptide ];

      environment.systemPackages = [
        pkgs.file
        pkgs.curl
        pkgs.which
        pkgs.zsh
      ];

      virtualisation = {
        containers.enable = true;
        oci-containers.backend = "podman";
        podman = {
          enable = true;
          dockerCompat = true;
          defaultNetwork.settings.dns_enabled = true;
        };
      };

      users = {
        mutableUsers = false;

        users = {
          user1 = {
            isNormalUser = true;
            uid = 1000;
            password = "pass1";
          };
        };
      };

      services.riptide = {
        enable = true;
        user = "user1";
        dockerHost = "unix:///run/user/1000/podman/podman.sock";
        proxy = {
          enable = true;
          ports = {
            http = 8080;
          };
        };
        extraConfig = {
          performance = {
            dont_sync_named_volumes_with_host = true;
          };
        };
      };
    };

  testScript =
    let
      user = "user1";
      password = "pass1";
      config = ''
        riptide:
          engine: docker
          performance:
            dont_sync_named_volumes_with_host: true
            dont_sync_unimportant_src: auto
          proxy:
            autostart: true
            ports:
              http: 8080
              https: 443
            url: riptide.local
          repos:
          - https://github.com/theCapypara/riptide-repo.git
          update_hosts_file: /var/riptide/user1/hosts/hosts
      '';
    in
    ''
      system1.wait_for_unit("multi-user.target")
      system1.wait_until_succeeds("pgrep -f 'agetty.*tty1'")
      system1.sleep(2)
      system1.send_key("alt-f2")
      system1.wait_until_succeeds("[ $(fgconsole) = 2 ]")
      system1.wait_for_unit("getty@tty2.service")
      system1.wait_until_succeeds("pgrep -f 'agetty.*tty2'")
      system1.wait_until_tty_matches("2", "login: ")
      system1.send_chars("${user}\n")
      system1.wait_until_tty_matches("2", "login: ${user}")
      system1.wait_until_succeeds("pgrep login")
      system1.sleep(2)
      system1.send_chars("${password}\n")
      system1.send_chars("whoami > /tmp/1\n")
      system1.wait_for_file("/tmp/1")
      assert "${user}" in system1.succeed("cat /tmp/1")

      system1.send_chars("file ~/.config/riptide/config.yml > /tmp/2\n")
      system1.wait_for_file("/tmp/2")
      assert "symbolic link" in system1.succeed("cat /tmp/2")

      system1.send_chars("cat ~/.config/riptide/config.yml > /tmp/3\n")
      system1.wait_for_file("/tmp/3")
      output = system1.succeed("cat /tmp/3").strip()
      assert """${config}""".strip() == output, f"output: {output}"

      # Prevent update check
      system1.send_chars("echo '{\"time\": 9999999999, \"versions\": {}}' > ~/.config/riptide/versions.json\n")

      system1.send_chars("riptide config-dump &> /tmp/3b\n")
      system1.wait_for_file("/tmp/3b")
      system1.sleep(5)
      output = system1.succeed("cat /tmp/3b")
      assert "riptide:" in output, f"output: {output}"

      system1.succeed("systemctl is-active --quiet dnsmasq")
      system1.sleep(20)
      system1.succeed("systemctl is-active --quiet riptide")

      system1.succeed("cat /var/riptide/${user}/hosts/hosts")
      system1.send_chars("echo \"127.0.0.9 foo.bar\" > /var/riptide/${user}/hosts/hosts\n")
      system1.sleep(10)
      output = system1.succeed("journalctl -u dnsmasq --no-pager")
      assert "read /var/riptide/${user}/hosts/hosts - 1 names" in output, f"output: {output}"
      # XXX: This doesn't work in the headless NixOS tests.
      # Probably something network related but I couldn't figure it out.
      #system1.send_chars("getent hosts foo.bar > /tmp/4\n")
      #system1.wait_for_file("/tmp/4")
      #system1.sleep(2)
      #output = system1.succeed("cat /tmp/4")
      #assert "127.0.0.9" in output, f"output: {output}"

      # make sure the shell integration scripts work
      system1.succeed("which nix-riptide.hook.bash")
      system1.succeed("bash -c 'echo $(nix-riptide.hook.bash) | grep PROMPT_COMMAND'")
      system1.succeed("bash -c '. <(nix-riptide.hook.bash)'")
      system1.succeed("which nix-riptide.hook.zsh")
      system1.succeed("bash -c 'echo $(nix-riptide.hook.zsh) | grep riptide_cwdir_hook'")
      system1.succeed("zsh -c '. <(nix-riptide.hook.zsh)'")

      system1.succeed("which riptide")
      system1.succeed("which riptide_proxy")
      system1.succeed("which _riptide-python")

      system1.succeed("curl http://127.0.0.1:8080")
      system1.succeed("curl -k https://127.0.0.1")

    '';
}
