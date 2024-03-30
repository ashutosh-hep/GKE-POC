export CLOUDSDK_CORE_DISABLE_PROMPTS=1

curl https://sdk.cloud.google.com > install.sh

bash install.sh --disable-prompts

gcloud auth list

secret_value=$(gcloud secrets versions access latest --secret=bq-readonly-key)

export secret_value && printenv | grep secret_value

sleep 3600
