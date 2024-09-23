|Riptide|
=========

.. |Riptide| image:: https://riptide-docs.readthedocs.io/en/latest/_images/logo.png
    :alt: Riptide

.. class:: center

    ======================  ===================  ===================  ===================
    *Main packages:*        lib_                 proxy_               cli_
    *Container-Backends:*   engine_docker_
    *Database Drivers:*     db_mysql_            db_mongo_
    *Plugins:*              php_xdebug_
    *Related Projects:*     configcrunch_
    *More:*                 docs_                repo_                docker_images_
    ======================  ===================  ===================  ===================

.. _lib:            https://github.com/Parakoopa/riptide-lib
.. _cli:            https://github.com/Parakoopa/riptide-cli
.. _proxy:          https://github.com/Parakoopa/riptide-proxy
.. _configcrunch:   https://github.com/Parakoopa/configcrunch
.. _engine_docker:  https://github.com/Parakoopa/riptide-engine-docker
.. _db_mysql:       https://github.com/Parakoopa/riptide-db-mysql
.. _db_mongo:       https://github.com/Parakoopa/riptide-db-mongo
.. _docs:           https://github.com/Parakoopa/riptide-docs
.. _repo:           https://github.com/Parakoopa/riptide-repo
.. _docker_images:  https://github.com/Parakoopa/riptide-docker-images
.. _php_xdebug:     https://github.com/Parakoopa/riptide-plugin-php-xdebug
.. _k8s_client:     https://github.com/Parakoopa/riptide-k8s-client
.. _k8s_controller: https://github.com/Parakoopa/riptide-k8s-controller

|build| |docs| |pypi-version| |pypi-downloads| |pypi-license| |pypi-pyversions|

.. |build| image:: https://img.shields.io/github/actions/workflow/status/theCapypara/riptide-all/build.yml
    :target: https://github.com/Parakoopa/riptide-all/actions
    :alt: Build Status

.. |docs| image:: https://readthedocs.org/projects/riptide-docs/badge/?version=latest
    :target: https://riptide-docs.readthedocs.io/en/latest/?badge=latest
    :alt: Documentation Status

.. |pypi-version| image:: https://img.shields.io/pypi/v/riptide-all
    :target: https://pypi.org/project/riptide-all/
    :alt: Version

.. |pypi-downloads| image:: https://img.shields.io/pypi/dm/riptide-all
    :target: https://pypi.org/project/riptide-all/
    :alt: Downloads

.. |pypi-license| image:: https://img.shields.io/pypi/l/riptide-all
    :alt: License (MIT)

.. |pypi-pyversions| image:: https://img.shields.io/pypi/pyversions/riptide-all
    :alt: Supported Python versions

Riptide is a set of tools to manage development environments for web applications.
It's using container virtualization tools, such as `Docker <https://www.docker.com/>`_
to run all services needed for a project.

It's goal is to be easy to use by developers.
Riptide abstracts the virtualization in such a way that the environment behaves exactly
as if you were running it natively, without the need to install any other requirements
the project may have.

Meta Package
------------

Installing this package will install all Riptide components in the matching version numbers.

Nix Flake
---------

This repository additionally contains a Nix Flake for installing and configuring Riptide on
NixOS and on macOS via nix-darwin. See the documentation for more information:

- `NixOS module <http://riptide-docs.readthedocs.io/en/latest/installation/linux_nixos.html>`
- `nix-darwin module <http://riptide-docs.readthedocs.io/en/latest/installation/macos_nix_darwin.html>`

Documentation
-------------

The complete documentation for Riptide can be found at `Read the Docs <https://riptide-docs.readthedocs.io/en/latest/>`_.