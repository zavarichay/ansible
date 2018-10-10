app_user: wwwkiiiosk
app_site_name: kiiiosk.ru
app_db_name: wwwkiosk
app_db_password: FGFgdfFFfdg
app_db_pool: 100

postgresql_user: wwwkiiiosk
postgresql_database: wwwkiosk
postgresql_password: "{{ lookup('env','PG_USER_PASSWORD') }}"

postgresql_version: 9.6
postgresql_encoding: 'UTF-8'
postgresql_locale: 'en_US.UTF-8'
postgresql_ctype: 'en_US.UTF-8'

postgresql_admin_user: "postgres"
postgresql_default_auth_method: "trust"

postgresql_service_enabled: false # should the service be enabled, default is true

postgresql_listen_addresses: '*'

postgresql_max_connections: 250
postgresql_shared_buffers: 50GB
postgresql_effective_cache_size: 150GB
postgresql_work_mem: 256MB
postgresql_maintenance_work_mem: 2GB
postgresql_min_wal_size: 1GB
postgresql_max_wal_size: 2GB
postgresql_checkpoint_completion_target: 0.7
postgresql_wal_buffers: 16MB
postgresql_default_statistics_target: 100

postgresql_users:
  - name: '{{ postgresql_user }}'
    pass: '{{ postgresql_password }}'
    encrypted: no       # denotes if the password is already encrypted.

postgresql_databases:
  - name:   '{{ postgresql_database }}'
    owner: postgres

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
  - { type: host, database: '{{ postgresql_database }}', user: '{{ postgresql_user }}', address: '136.243.75.79/32', method: 'md5', comment: 'db1.kiiiosk.ru' }
