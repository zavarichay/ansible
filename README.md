# ansible

## Подготовка

Установть пароль для wwwkiosk в PG_USER_PASSWORD если планируем побновлять db2.kiiiosk.ru

## Установка ansbile локально

1. Иметь установленным локально ansible

2. Установить модули для ansible

> make

## Настроить конкретный сервер (например onelec.ru)

> ansible-playbook playbook.yml -i hosts --limit onelec.ru

## Настроить все сервера

> make play

# Первичная настройка чистого сервера (на котором еще не стоит ansible)

* Добавить в hosts

> SETUP_HOST=host_name make install
> ansible -m setup host_name
> ansible-playbook ./playbook.yml --limit host_name -i ./hosts

# TODO

* Добавить systemctl enable zabbix-agent  при настройке zabbix-agent
* https://discuss.elastic.co/t/total-fields-limit-setting/53004/6
    curl -XPUT db2.kiiiosk.ru:9200/kiiiosk_goods/_settings -d '{"mapping.total_fields.limit" : 3000}'
