# How to run Airflow in Kubernetes

Option 1 - Helm Chart

https://airflow.apache.org/docs/helm-chart/stable/quick-start.html#install-kind-and-create-a-cluster

## Create Cluster
kind create cluster --image kindest/node:v1.21.1

## Add helm chart
helm repo add apache-airflow https://airflow.apache.org
helm repo update

## install airflow
Create namespace and install airflow chart
kubectl create namespace airflow-cluster
helm install airflow apache-airflow/airflow --namespace airflow-cluster


## Get cluster info and port forward
kubectl cluster-info --context kind-kind
kubectl port-forward svc/airflow-webserver 8080:8080 -n airflow --context kind-airflow-cluster

## Adding DAGs to your image
Custom image is created from Dockerfile, dags and dependecies are included into image for loading it with kind

docker build --pull --tag airflow-local-build:0.0.1 .
kind load docker-image airflow-local-build:0.0.1
helm upgrade airflow apache-airflow/airflow --namespace airflow-cluster --set images.airflow.repository=airflow-local-build --set images.airflow.tag=0.0.1 --timeout 10m30s

## Get the Chart values
helm show values apache-airflow/airflow > values.yaml


## Clean up cluster
kind delete cluster --image kindest/node:v1.21.1

## Possible issues 

helm time out > 
 - add --timeout 10m30s to install/updgrade

Error: UPGRADE FAILED: post-upgrade hooks failed: timed out waiting for the condition
 - Review docker build image is creating image in same version or older


Option 2 - Kubernetes yaml defintions	
 - https://github.com/danielbeach/airflow-kubernetes/tree/master



## References
https://www.notion.so/Airflow-Helm-Chart-Quick-start-for-Beginners-3e8ee61c8e234a0fb775a07f38a0a8d4
https://www.youtube.com/watch?v=giQReCd7jp8
https://www.youtube.com/watch?v=X48VuDVv0do
https://www.youtube.com/watch?v=kkW7LNCsK74
https://www.confessionsofadataguy.com/deploying-apache-airflow-inside-kubernetes/
https://imsharadmishra.medium.com/running-airflow-2-0-on-kubernetes-locally-using-minikube-da91fc07f32d
https://medium.com/@ipeluffo/running-apache-airflow-locally-on-kubernetes-minikube-31f308e3247a
