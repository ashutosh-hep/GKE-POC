echo "starting to provision"

kubectl create ns monitor

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install prometheus prometheus-community/prometheus -n monitor

kubectl expose service prometheus-server --type=NodePort --target-port=9090 --name=prometheus-server-ext -n monitor

helm repo add grafana https://grafana.github.io/helm-charts 
helm repo update

helm install grafana grafana/grafana -n monitor

kubectl expose service grafana --type=NodePort --target-port=3000 --name=grafana-ext -n monitor

kubectl get svc -n monitor
echo "use port starting like 300000"

echo "setup completed"

kubectl get nodes -o wide | awk -v OFS='\t\t' '{print $1, $6, $7}'
echo "use one of these node public IP to access prmetheous and kibana"

kubectl get secret --namespace mn grafana -o jsonpath="{.data.admin-password}"
echo "decode above secret into base64"

echo "use admin as user and above decrypted secret as password to log in grafana"



