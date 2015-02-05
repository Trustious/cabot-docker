#!/bin/bash

export DATABASE_URL="postgres://docker:docker@localhost:5432/docker"
export CELERY_BROKER_URL="redis://localhost:6379/1"
export SES_HOST="localhost"
export SES_USER=""
export SES_PASS=""
export SES_PORT="25"

mkdir -p /var/log/cabot

service nginx restart &&\
gunicorn cabot.wsgi:application --config gunicorn.conf --log-level info --log-file /var/log/cabot/gunicorn &\
celery worker -B -A cabot --loglevel=INFO --concurrency=16 -Ofair
