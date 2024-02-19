#import "@preview/colorful-boxes:1.2.0": *
= Практические задание

== Задание 1
#colorbox(
  title: "TODO",
  color: "blue",
  radius: 2pt,
  width: auto
)[
  Настройте свой веб-сервер (nginx+php+mysql или что-то подобное). Контент на сервере
мне не важен, подойдет любая дефолтная CMS (Wordpress, Drupal итд)
]

=== Настройка
\
Будем настривать *Wordpress* с *nginx+php+mysql* в *docker*:

+ Напишем *docker-compose*:
        ```yaml
        version: '3.9'

        services:
        mysql:
        image: mysql:8.0
        container_name: mysql8
        restart: unless-stopped
        env_file: .env
        volumes:
        - dbfile:/var/lib/mysql
        command: '--default-authentication-plugin=mysql_native_password'
        networks:
        - app

        wp:
        image: wordpress:5.7.0-php8.0-fpm
        container_name: wordpress-5.7.0-php8.0-fpm
        depends_on:
        - mysql
        restart: unless-stopped
        env_file: .env
        environment:
        - WORDPRESS_DB_HOST=mysql:3306
        - WORDPRESS_DB_USER=$MYSQL_USER
        - WORDPRESS_DB_PASSWORD=$MYSQL_PASSWORD
        - WORDPRESS_DB_NAME=$MYSQL_DATABASE
        volumes:
        - www-html:/var/www/html
        networks:
        - app

        nginx:
        image: nginx:1.19.8-alpine
        depends_on:
        - wp
        container_name: nginx-1.19.8-alpine
        restart: unless-stopped
        ports:
        - "80:80"
        volumes:
        - www-html:/var/www/html
        - ./nginx-conf.d:/etc/nginx/conf.d
        networks:
        - app

        volumes:
        www-html:
        dbfile:

        networks:
        app:
        driver: bridge
        ```
        + MySQL Service (mysql):
                - Используется образ MySQL версии 8.0.
                - Название контейнера: mysql8.
                - Перезапускается при необходимости.
                - Использует файл с переменными окружения (.env) для настройки окружения.
                - Данные MySQL сохраняются в Docker Volume dbfile.
                - Задана команда для использования стандартной аутентификации MySQL.
        + WordPress Service (wp):
                - Используется образ WordPress версии 5.7.0 с PHP версии 8.0 в роли FPM (FastCGI Process Manager).
                - Название контейнера: wordpress-5.7.0-php8.0-fpm.
                - Зависит от сервиса MySQL (mysql) и перезапускается при необходимости.
                - Использует файл с переменными окружения (.env) для настройки окружения.
                - Данные WordPress сохраняются в Docker Volume www-html.
                - Связан с сетью app.
        + Nginx Service (nginx):
                - Используется образ Nginx версии 1.19.8-alpine.
                - Название контейнера: nginx-1.19.8-alpine.
                - Зависит от сервиса WordPress (wp) и перезапускается при необходимости.
                - Пробрасывает порт 80.
                - Монтирует Docker Volume www-html для обмена файлами с WordPress и локальный каталог ./nginx-conf.d для -настроек Nginx.
                - Связан с сетью app.
        + Volumes:
                - www-html: Используется для хранения данных WordPress и общего доступа с контейнерами wp и nginx.
                - dbfile: Используется для хранения данных MySQL.
        + Networks:
                - app: Используется для связи контейнеров в рамках одной сети.


+ Создадим директорию nginx-conf.d
+ Внутри nginx-conf.d создаим файл конфигурации .conf
        ```
        server {
                listen 80;
                listen [::]:80;

                server_name  my.server.ru;

                index index.php index.html index.htm;

                root /var/www/html;

                location / {
                        try_files $uri $uri/ /index.php$is_args$args;
                }

                location ~ \.php$ {
                        try_files $uri =404;
                        fastcgi_split_path_info ^(.+\.php)(/.+)$;
                        fastcgi_pass wp:9000;
                        fastcgi_index index.php;
                        include fastcgi_params;
                        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                        fastcgi_param PATH_INFO $fastcgi_path_info;
                }

                location ~ /\.ht {
                        deny all;
                }

                location = /favicon.ico {
                        log_not_found off;
                }
                location = /robots.txt {
                        log_not_found off;
                }
                location ~* \.(css|gif|ico|jpeg|jpg|js|png)$ {
                        expires max;
                        log_not_found off;
                }
        }

        ```
+ Добавим в nginx-conf.d файл .env с информацие о базе данных
        ```env
        MYSQL_ROOT_PASSWORD=Be$t)P@s$w0rdR00T-u$eR
        MYSQL_USER=wp_db_user
        MYSQL_PASSWORD=W0rdpres$%d@taBa$e%paS$worD
        MYSQL_DATABASE=wp_db
        ```
+ Запустим веб сервер командой
        ```bash
        docker compose up -d
        ```
+ Можем просматривать логи с помощью команд
        ```bash
        docker-compose logs php
        docker-compose logs mysql
        docker-compose logs nginx
        ```
+ завершаем работу серверам
        ```bash
        docker compose down
        ```

=== Результаты
#figure(
  image("../pics/1.png", width: 100%),
  caption: [
   Шаг 1
  ],
)

#figure(
  image("../pics/2.png", width: 100%),
  caption: [
   Шаг 2
  ],
)

== Задание 2
#colorbox(
  title: "TODO",
  color: "blue",
  radius: 2pt,
  width: auto
)[
  Расскажите, какие настройки для оптимизации можно использовать (увеличение скорости
работы, увеличение надежности, SSL)
]

Оптимизация веб-сервера и приложений в Docker-контейнерах может включать в себя различные настройки для увеличения производительности, надежности и безопасности. Ниже приведены некоторые общие рекомендации:

=== Nginx:
+ Оптимизация конфигурации Nginx:
        - Используйте оптимальные параметры воркеров и соединений.
        - Настройте буферизацию и кеширование для статических ресурсов.
        - Включите gzip-сжатие для уменьшения объема передаваемых данных.
+ SSL-настройки:
        - Используйте современные версии протоколов TLS.
        - Включите Perfect Forward Secrecy (PFS) для усиления безопасности.
+ Keepalive и таймауты:
        - Настройте keepalive_timeout и keepalive_requests для эффективного использования соединений.
        - Установите разумные значения таймаутов для обработки запросов.
=== PHP-FPM:
+ Оптимизация пула PHP-FPM:
        - Настройте размеры пула и параметры ожидания соединений, чтобы соответствовать объему запросов.
        - Используйте динамическое масштабирование пула для более эффективного использования ресурсов.
+ Оптимизация PHP:
        - Включите оптимизации OPcache для уменьшения времени загрузки скриптов.
        - Установите разумные значения параметров memory_limit и max_execution_time.
=== MySQL:
+ Настройка параметров MySQL:
        - Оптимизируйте параметры конфигурации MySQL, такие как innodb_buffer_pool_size, 
        query_cache_size.


#pagebreak()