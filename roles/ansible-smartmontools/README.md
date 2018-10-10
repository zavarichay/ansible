## ansible-smartmontools - [![Build Status](https://travis-ci.org/grimmjow8/ansible-smartmontools.png)](https://travis-ci.org/grimmjow8/ansible-smartmontools)

Ansible role installs smartmontools and sets smartd configuration.

Requirements
------------

- Tested on ansible 2.1.2.0

Variables
---------

__smartd_email - smartd reporting email address

Example Playbook
----------------

    - hosts: all
      roles:
         - { role: grimmjow8.ansible-smartmontools }


Testing
-------

\<path\>/ansible-smartmontools $ ansible-playbook test.yml 


License
-------

Licensed under the MIT License. See the LICENSE file for details.

Author Information
------------------

TBD
