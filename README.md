# ![Riptide](https://riptide-docs.readthedocs.io/en/latest/_images/logo.png)

[<img src="https://img.shields.io/github/actions/workflow/status/theCapypara/riptide-all/build.yml" alt="Build Status">](https://github.com/theCapypara/riptide-all/actions)
[<img src="https://readthedocs.org/projects/riptide-docs/badge/?version=latest" alt="Documentation Status">](https://riptide-docs.readthedocs.io/en/latest/)
[<img src="https://img.shields.io/pypi/v/riptide-all" alt="Version">](https://pypi.org/project/riptide-all/)
[<img src="https://img.shields.io/pypi/dm/riptide-all" alt="Downloads">](https://pypi.org/project/riptide-all/)
<img src="https://img.shields.io/pypi/l/riptide-all" alt="License (MIT)">
<img src="https://img.shields.io/pypi/pyversions/riptide-all" alt="Supported Python versions">

Riptide is a set of tools to manage development environments for web applications.
It's using container virtualization tools, such as [Docker](https://www.docker.com/)
to run all services needed for a project.

Its goal is to be easy to use by developers.
Riptide abstracts the virtualization in such a way that the environment behaves exactly
as if you were running it natively, without the need to install any other requirements
the project may have.

Riptide consists of a few repositories, find the
entire [overview](https://riptide-docs.readthedocs.io/en/latest/development.html) in the documentation.

## Meta Package

Installing this package will install all Riptide components in the matching version numbers.

## Nix Flake

This repository additionally contains a Nix Flake for installing and configuring Riptide on
NixOS and on macOS via nix-darwin. See the documentation for more information:

- `NixOS module <http://riptide-docs.readthedocs.io/en/latest/installation/linux_nixos.html>`
- `nix-darwin module <http://riptide-docs.readthedocs.io/en/latest/installation/macos_nix_darwin.html>`

## Documentation

The complete documentation for Riptide can be found at [Read the Docs](https://riptide-docs.readthedocs.io/en/latest/).

[cli]: https://github.com/Parakoopa/riptide-cli

[configcrunch]: https://github.com/Parakoopa/configcrunch

[db_mongo]: https://github.com/Parakoopa/riptide-db-mongo

[db_mysql]: https://github.com/Parakoopa/riptide-db-mysql

[docker_images]: https://github.com/Parakoopa/riptide-docker-images

[docs]: https://github.com/Parakoopa/riptide-docs

[engine_docker]: https://github.com/Parakoopa/riptide-engine-docker

[k8s_client]: https://github.com/Parakoopa/riptide-k8s-client

[k8s_controller]: https://github.com/Parakoopa/riptide-k8s-controller

[lib]: https://github.com/Parakoopa/riptide-lib

[php_xdebug]: https://github.com/Parakoopa/riptide-plugin-php-xdebug

[proxy]: https://github.com/Parakoopa/riptide-proxy

[repo]: https://github.com/Parakoopa/riptide-repo
