__version__ = '0.6.0'

from setuptools import setup

# README read-in
from os import path
this_directory = path.abspath(path.dirname(__file__))
with open(path.join(this_directory, 'README.rst'), encoding='utf-8') as f:
    long_description = f.read()
# END README read-in

setup(
    name='riptide-all',
    version=__version__,
    packages=[],
    description='Tool to manage development environments for web applications using containers - Meta Package',
    long_description=long_description,
    long_description_content_type='text/x-rst',
    url='https://github.com/Parakoopa/riptide-all/',
    install_requires=[
        'riptide-lib >= 0.6.0, < 0.7',
        'riptide-cli >= 0.6.0, < 0.7',
        'riptide-proxy >= 0.6.0, < 0.7',
        'riptide-engine-docker >= 0.6.0, < 0.7',
        'riptide-db-mysql >= 0.6.0, < 0.7',
        'riptide-plugin-php-xdebug >= 0.6.0, < 0.7'
    ],
    classifiers=[
        'Development Status :: 3 - Alpha',
        'Programming Language :: Python',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
    ],
)
