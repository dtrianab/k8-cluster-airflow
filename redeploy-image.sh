export NAMESPACE=airflow-cluster
export RELEASE_NAME=airflow
set -x
+ echo  'updatinng dags submodule'
git submodule init 
git submodule update
+ echo 'Building Custom Docker image.'
docker build --pull --tag airflow-local-build:0.0.1 .
kind load docker-image airflow-local-build:0.0.1
helm upgrade $RELEASE_NAME apache-airflow/airflow --namespace $NAMESPACE --set images.airflow.repository=airflow-local-build --set images.airflow.tag=0.0.1 --timeout 10m30s
kubectl rollout restart deployment -n $NAMESPACE
set +x