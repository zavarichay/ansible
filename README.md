# db-server-ansible

## Подготовка

Установть пароль для wwwkiosk в PG_USER_PASSWORD

## Установка ansbile локально

Иметь установленным локально ansible

> make

## Установить все на все

> make play


## Настройка чистого сервера

* Добавить в hosts

> SETUP_HOST=host_name make install
> ansible -m setup host_name
> ansible-playbook ./playbook.yml --limit host_name -i ./hosts
