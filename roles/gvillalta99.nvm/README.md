gvillalta99.nvm
===============

Install nvm and Node.js.

This role is an extension of [ahmednuaman/ansible-nvm](https://github.com/ahmednuaman/ansible-nvm)

Installation
------------

`$ ansible-galaxy install gvillalta99.nvm`

Dependencies
------------

On Fedora:

  - git
  - gcc
  - gcc-c++
  - make
  - openssl-devel
  - libselinux-python

On Ubuntu:

  - git
  - curl
  - build-essential
  - libssl-dev

Example Playbook
----------------

    - hosts: servers
      roles:
        - role: nvm
          nvm:
            default_node_version: "0.12"
            node_versions:
              - '0.12.2'
              - '0.11'
              - '0.10'
              - iojs
            packages:
              - grunt-cli
              - bower
              - yo
            path: "~/.nvm"
            profile_file: "~/.zshrc"
            version: 'v0.20.0'

Requirements
------------

- Tested on Fedora 21
- Tested on Ubuntu 14.04 (Trusty)

License
-------

BSD
