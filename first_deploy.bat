set NAMESPACE=airflow-cluster
set RELEASE_NAME=airflow
echo  'updatinng dags submodule from github'
git submodule update --init
git submodule update --init --recursive

echo  'Creating cluster'
kind create cluster --image kindest/node:v1.21.1

echo 'Updating helm repo'
helm repo add apache-airflow https://airflow.apache.org --debug
helm repo update

echo 'Create ns and install chart'
kubectl create namespace %NAMESPACE%
helm install %RELEASE_NAME% apache-airflow/airflow --namespace %NAMESPACE% --debug --timeout 10m30s