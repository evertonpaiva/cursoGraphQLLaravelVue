#!/bin/bash

#WEB
WEB_CONTAINER_NAME=booksql-laravel
WEB_LOCAL_DIR=~/git/github/cursoGraphQLLaravelVue/booksql-laravel

echo -e "\nRemovendo containers, caso existam"
docker-compose down

# Testando se já existe arquivo de configuração local
if [ ! -f "$WEB_LOCAL_DIR/.env" ]; then
    echo -e "Criando arquivo de configuração local .env "
    cp "$WEB_LOCAL_DIR"/.env.dev "$WEB_LOCAL_DIR"/.env
fi

echo -e "\nCorrigindo permissao nas pastas"

echo -e "\nAlterando grupo e proprietario da pasta do app"
sudo chown $USER:www-data -R $WEB_LOCAL_DIR

echo -e "\nAdicionando permissao de escrita para o grupo na pasta storage"
sudo chmod o+w -R $WEB_LOCAL_DIR/storage
sudo chmod g+w -R $WEB_LOCAL_DIR/storage

if [ -d "$WEB_LOCAL_DIR/bootstrap/cache" ]; then
    echo -e "\nAdicionando permissao de escrita para na pasta do bootstrap"
    sudo chmod g+w -R $WEB_LOCAL_DIR/bootstrap/cache
fi

echo -e "\nConstruindo a imagem localmente"
docker-compose build

echo -e "\nInstalando dependências localmente"
docker run -i --rm -v booksql-laravel:/app -e APP_ENV=dev $WEB_CONTAINER_NAME composer self-update
docker run -i --rm -v booksql-laravel:/app -e APP_ENV=dev $WEB_CONTAINER_NAME composer install

echo -e "\nIniciando container"
docker-compose up -d

echo -e "\nAcompanhe a instalacao em: docker-compose logs -f"
