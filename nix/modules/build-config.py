#!/usr/bin/env python3
import sys
import json
import yaml
from mergedeep import merge


def main():
    config_yml_path = sys.argv[-1]
    hosts_file = sys.argv[-2]
    config = sys.argv[-3]

    config = json.loads(config)

    if hosts_file == "":
        update_hosts_file_value = config["resolveProjectHosts"]
    else:
        update_hosts_file_value = hosts_file if config["resolveProjectHosts"] else False

    out_config = {
        "riptide": merge({
            "proxy": {
                "url": config["proxy"]["url"],
                "ports": {
                    "http": config["proxy"]["ports"]["http"],
                    "https": config["proxy"]["ports"]["https"]
                },
                "autostart": config["proxy"]["autostart"],
            },
            "repos": config["repos"],
            "update_hosts_file": update_hosts_file_value,
            "engine": config["engine"]["name"],
            "performance": {
                "dont_sync_named_volumes_with_host": "auto",
                "dont_sync_unimportant_src": "auto"
            }
        }, config["extraConfig"])
    }

    with open(config_yml_path, 'w') as f:
        yaml.dump(out_config, f)


if __name__ == "__main__":
    main()
