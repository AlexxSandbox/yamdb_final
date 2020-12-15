#!/usr/bin/env bash
/usr/local/bin/python manage.py makemigrations --noinput
/usr/local/bin/python manage.py migrate
/usr/local/bin/python manage.py collectstatic --noinput
/usr/local/bin/gunicorn api_yamdb.wsgi:application --bind 0.0.0.0:8000
/bin/bash