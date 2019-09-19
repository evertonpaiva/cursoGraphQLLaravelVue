#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#WEB
BACK_CONTAINER_NAME=booksql-laravel
BACK_LOCAL_DIR=$SCRIPT_DIR/booksql-laravel

echo -e "\nRemovendo containers, caso existam"
docker-compose down

# Testando se já existe arquivo de configuração local
if [ ! -f "$BACK_LOCAL_DIR/.env" ]; then
    echo -e "Criando arquivo de configuração local .env "
    cp "$BACK_LOCAL_DIR"/.env.dev "$BACK_LOCAL_DIR"/.env
fi

echo -e "\nCorrigindo permissao nas pastas"

echo -e "\nAlterando grupo e proprietario da pasta do app"
sudo chown $USER:www-data -R $BACK_LOCAL_DIR

echo -e "\nAdicionando permissao de escrita para o grupo na pasta storage"
sudo chmod o+w -R $BACK_LOCAL_DIR/storage
sudo chmod g+w -R $BACK_LOCAL_DIR/storage

if [ -d "$BACK_LOCAL_DIR/bootstrap/cache" ]; then
    echo -e "\nAdicionando permissao de escrita para na pasta do bootstrap"
    sudo chmod g+w -R $BACK_LOCAL_DIR/bootstrap/cache
fi

echo -e "\nConstruindo as imagens localmente"
docker-compose build

echo -e "\nInstalando dependências localmente - Laravel"
docker run -i --rm -v booksql-laravel:/app -e APP_ENV=dev $BACK_CONTAINER_NAME composer self-update
docker run -i --rm -v booksql-laravel:/app -e APP_ENV=dev $BACK_CONTAINER_NAME composer install

echo -e "\nInstalando dependências localmente - Vue"
docker run -i --rm -v booksql-vue:/app booksql-vue npm install

echo -e "\nIniciando containers"
docker-compose up -d

echo -e "\nAcompanhe a instalacao em: docker-compose logs -f"
