FROM node:14-alpine3.16


CMD ["key=$(cat /var/secrets/bq-readonly-key)"]
ENTRYPOINT ["export", "key"]
