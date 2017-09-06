# elasticsearch 9200 тут не светим, потому что
# к нему открывается доступ с IP сервера
iptables_allowed_tcp_ports: [22, 80, 443, 10050]

iptables_raw_rules:
  - "-A INPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j REJECT --reject-with icmp-port-unreachable"
  - "-A INPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG FIN,SYN,RST,PSH,ACK,URG -j REJECT --reject-with icmp-port-unreachable"
  - "-A INPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG FIN,PSH,URG -j REJECT --reject-with icmp-port-unreachable"
  - "-A INPUT -p tcp -m tcp --tcp-flags FIN,SYN FIN,SYN -j REJECT --reject-with icmp-port-unreachable"
  - "-A INPUT -p tcp -m tcp --tcp-flags SYN,RST SYN,RST -j REJECT --reject-with icmp-port-unreachable"
  - "-A INPUT -p tcp -m tcp --tcp-flags FIN,RST FIN,RST -j REJECT --reject-with icmp-port-unreachable"
  - "-A INPUT -p tcp -m tcp --tcp-flags FIN,ACK FIN -j REJECT --reject-with icmp-port-unreachable"
  - "-A INPUT -p tcp -m tcp --tcp-flags PSH,ACK PSH -j REJECT --reject-with icmp-port-unreachable"
  - "-A INPUT -p tcp -m tcp --tcp-flags ACK,URG URG -j REJECT --reject-with icmp-port-unreachable"
  - "-A INPUT -s 136.243.75.105  -j ACCEPT -m comment --comment srv-1.kiiiosk.ru"
  - "-A INPUT -s 136.243.75.79 -j ACCEPT -m comment --comment db1.kiiiosk.ru"
  - "-A INPUT -s 136.243.75.106 -j ACCEPT -m comment --comment db2.kiiiosk.ru"
  - "-A INPUT -s 94.232.57.6 -j ACCEPT -m comment --comment office.brandymint.ru"


es_version: "5.5.2"
es_instance_name: "node1"
es_config:
  network.host: "{{ hostvars[inventory_hostname]['ansible_default_ipv4']['address'] }}" # '136.243.75.106' # db2.kiiiosk.ru
  discovery.zen.ping.unicast.hosts: "localhost:9300"
  http.port: 9200
  transport.tcp.port: 9300
es_plugins:
  - plugin: analysis-morphology

cron_tasks:
  - name: vacuumdb
    hour: 0
    minute: 47
    job: /usr/bin/vacuumdb -U postgres -afzv > /var/log/vacuumdb.log 2>&1

postgresql_user: wwwkiiiosk
postgresql_database: kiosk_production
postgresql_password: "{{ lookup('env','PG_USER_PASSWORD') }}"
postgresql_version: 9.6
postgresql_encoding: 'UTF-8'
postgresql_locale: 'en_US.UTF-8'
postgresql_ctype: 'en_US.UTF-8'

postgresql_admin_user: "postgres"
postgresql_default_auth_method: "trust"

postgresql_service_enabled: false # should the service be enabled, default is true

postgresql_users:
  - name: '{{ postgresql_user }}'
    pass: '{{ postgresql_password }}'
    encrypted: no       # denotes if the password is already encrypted.

postgresql_user_privileges:
  - name: '{{ postgresql_user }}'                   # user name
    db:   '{{ postgresql_database }}'
    priv: "ALL"                 # privilege string format: example: INSERT,UPDATE/table:SELECT/anothertable:ALL
    # role_attr_flags: "CREATEDB" # role attribute flags

postgresql_pg_hba_default:
  - { type: local, database: all, user: '{{ postgresql_admin_user }}', address: '', method: '{{ postgresql_default_auth_method }}', comment: '' }
  - { type: local, database: all, user: all, address: '',             method: '{{ postgresql_default_auth_method }}', comment: '"local" is for Unix domain socket connections only' }
  - { type: host, database: all, user: all, address: '127.0.0.1/32', method: '{{ postgresql_default_auth_method }}', comment: 'IPv4 local connections:' }
  - { type: host, database: all, user: all, address: '::1/128',      method: '{{ postgresql_default_auth_method }}', comment: 'IPv6 local connections:' }
  - { type: host, database: '{{ postgresql_database }}', user: '{{ postgresql_user }}', address: '136.243.75.105/32', method: 'md5', comment: 'srv-1.kiiiosk.ru' }

