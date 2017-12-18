iptables_allowed_tcp_ports: [20, 21, 22, 25, 80, 443, 3000, 9000, 10050]

postgresql_version: 9.6
postgresql_encoding: 'UTF-8'
postgresql_locale: 'en_US.UTF-8'
postgresql_ctype: 'en_US.UTF-8'

postgresql_admin_user: "postgres"
postgresql_default_auth_method: "trust"

postgresql_service_enabled: false # should the service be enabled, default is true

postgresql_listen_addresses: '*'

postgresql_max_connections: 150
postgresql_shared_buffers: 32GB
postgresql_effective_cache_size: 48GB
postgresql_work_mem: 256MB
postgresql_maintenance_work_mem: 2GB
postgresql_min_wal_size: 1GB
postgresql_max_wal_size: 2GB
postgresql_checkpoint_completion_target: 0.7
postgresql_wal_buffers: 16MB
postgresql_default_statistics_target: 100

postgresql_pg_hba_default:
  - { type: local, database: all, user: '{{ postgresql_admin_user }}', address: '', method: '{{ postgresql_default_auth_method }}', comment: '' }
  - { type: local, database: all, user: all, address: '',             method: '{{ postgresql_default_auth_method }}', comment: '"local" is for Unix domain socket connections only' }
  - { type: host, database: all, user: all, address: '127.0.0.1/32', method: '{{ postgresql_default_auth_method }}', comment: 'IPv4 local connections:' }
  - { type: host, database: all, user: all, address: '::1/128',      method: '{{ postgresql_default_auth_method }}', comment: 'IPv6 local connections:' }

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
  - "-A INPUT -s 136.243.75.107 -j ACCEPT -m comment --comment db2.kiiiosk.ru"
  - "-A INPUT -p tcp --dport 50000:60000 -m state --state RELATED,ESTABLISHED -j ACCEPT"
