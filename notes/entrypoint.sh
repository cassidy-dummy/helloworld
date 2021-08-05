#!/bin/bash

echo '{}' > /edx/etc/edx_notes_api.yml
gunicorn --workers=2 --name notes -c /edx/app/notes/notesserver/docker_gunicorn_configuration.py --log-file - --max-requests=1000 notesserver.wsgi:application
