[![Gitpod](https://img.shields.io/badge/Open%20in%20Gitpod-908a85?logo=gitpod)](https://gitpod.io/#https://github.com/Ex3mal186/kafka-exercises)

# Практические задания по Apache Kafka

Задания представляют собой набор docker compose сервисов для демонстрации работы с Apache Kafka. Каждая ветка демонстрирует какой-то аспект работы с Apache Kafka. Обычно docker-compose конфигурация включает 4 сервиса:

| Сервис | Описание | Доступные порты |
|--------|----------|------------------|
| `zookeeper` | Apache Zookeeper | 2181 |
| `kafka` | Брокер Apache Kafka. В случае, если необходимо несколько брокеров, то будет добавляться суффикс `N`, где `N` номер брокера | 9092 |
| `redpanda` | Web интерфейс для работы с Apache Kafka | [8080](http://localhost:8080) |
| `manager` | Jupute Notebook с bash командами для демонстрации | [8888](http://localhost:8888) |

# Быстрый старт

1. Для старта необходимо запустить скрипт `./start`: `bash ./start`. Скрипт объединяет в себе:
    - `docker compose pull` - загрузить все образы локально;
    - `docker compose build` - запустить сборку. Для Apache Kafka настраивается ssh, поэтому необходимо выполнить сборку образа;
    - `docker compose up` - запуск docker compose сервисов.
1. Открыть Jupyter Notebook в браузере: [http://localhost:8888](http://localhost:8888);
1. Выбрать файл с Jupter Notebook на панели слева: `work` => `kafka-basics.ipynb`;
1. Открыть web консоль redpanda: [http://localhost:8080](http://localhost:8080);
1. Переход к следующему шагу можно осуществить при помощи скрипта `./next`: `bash next`. Скрипт выполнит следующие действия:
    - остановит запущенные docker сервисы,
    - зафиксирует внесенные изменения в виде коммита,
    - переключится на следующую ветку.
