#!/bin/sh

rm /etc/nginx/conf.d/default.conf

nginx -g "daemon off;"
