set NAMESPACE=airflow-cluster
set RELEASE_NAME=airflow
kind create cluster --image kindest/node:v1.21.1
helm repo add apache-airflow https://airflow.apache.org --debug
helm repo update
kubectl create namespace %NAMESPACE%
helm install %RELEASE_NAME% apache-airflow/airflow --namespace %NAMESPACE% --debug --timeout 10m30s