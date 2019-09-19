#!/bin/bash

echo -e "\nCorrigindo permissões"
sudo chown evertonpaiva:www-data -R booksql-laravel/
sudo chown evertonpaiva:www-data -R booksql-vue/
