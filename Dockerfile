FROM node:14-alpine3.16


CMD ["/bin/sh", "-c","export $(cat /var/secrets/bq-readonly-key)"]
#ENTRYPOINT ["export", "$(cat /var/secrets/bq-readonly-key)"]
