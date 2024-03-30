FROM node:14-alpine3.16

ENTRYPOINT ["export", "$(cat /var/secretrs/bq-readonly-key)"]
