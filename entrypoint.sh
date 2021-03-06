#!/bin/sh

set -eux

export DJANGO_SETTINGS_MODULE=xqueue.production
export XQUEUE_CFG=/edx/app/xqueue/xqueue_cfg.yml

aws ssm get-parameter --name /xqueue/xqueue_cfg --with-decryption | jq -r '.Parameter.Value' > "${XQUEUE_CFG}"

./manage.py migrate
./manage.py update_users
gunicorn -c /edx/app/xqueue/xqueue/docker_gunicorn_configuration.py --bind=0.0.0.0:8040 --workers 2 --max-requests=1000 xqueue.wsgi:application
