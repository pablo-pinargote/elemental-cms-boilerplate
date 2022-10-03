#!/usr/bin/env bash
gunicorn main:www --bind 0.0.0.0:8000 -c gunicornhooks.py --workers 1 --timeout 0
