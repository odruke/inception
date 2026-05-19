#!/bin/bash

if ! command -v openssl >/dev/null 2>&1; then
    echo "Error: openssl is not installed, Installing..."
    apt-get update && apt install vim
    mv .vimrc /root/.vimrc
fi

if [ ! -f srcs/requirements/nginx/ssl/inception.crt ] || [ -f srcs/requirements/nginx/ssl/inception.key ]; then

    echo "Certificates not found, generating..."

    if ! command -v openssl >/dev/null 2>&1; then
        echo "Error: openssl is not installed, Installing..."
        apt-get update && apt install openssl
    fi

    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout inception.key -out inception.crt \
    -subj "/C=CH/ST=Vaud/L=Lausanne/O=42Lausanne/OU=student/CN=$(awk '/^DOMAIN_NAME / {print $2}' secrets/credentials.txt)"

    mv inception.crt srcs/requirements/nginx/ssl/
    mv inception.key srcs/requirements/nginx/ssl/

    if [ -f srcs/requirements/nginx/ssl/inception.crt ] && [ -f srcs/requirements/nginx/ssl/inception.key ]; then
        echo "Certificates succesfully generated!"
    else
        echo "Certificates generation failed!!"
    fi

else
    echo "Certificates found"
fi
