#!/usr/bin/env bash

APP_HOST=${APP_HOST:-0.0.0.0}
APP_PORT=${APP_PORT:-8000}

gunicorn main:www --bind "$APP_HOST":"$APP_PORT" -c gunicornhooks.py --workers 1 --timeout 0
