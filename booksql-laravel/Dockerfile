FROM hub.dds.ufvjm.edu.br/desenvolvimento/laravel-alpine-php7:latest

ENV PHP_MEMORY_LIMIT 384M
ENV APP_VERSION #dev

#Copiando o código do repositório para o working_dir (/app) do container
ADD . .

RUN chown -R apache:apache /app
RUN chmod g+w /app/storage
RUN sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini

RUN composer self-update

RUN composer install

CMD /usr/sbin/laravel-init
