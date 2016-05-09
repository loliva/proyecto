#!/bin/bash

yum install httpd bind mysql-server squid openssl -y

echo "Generando SSL para apache"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/httpd/ssl/telecenter.key -out /etc/httpd/ssl/telecenter.crt

echo "Copiando config httpd"
cp -rv ./config/httpd/* /etc/httpd
