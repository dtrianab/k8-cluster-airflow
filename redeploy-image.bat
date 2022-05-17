set NAMESPACE=airflow-cluster
set RELEASE_NAME=airflow
echo 'Building Custom Docker image...'
docker build --pull --tag airflow-local-build:0.0.1 .
kind load docker-image airflow-local-build:0.0.1
helm upgrade %RELEASE_NAME% apache-airflow/airflow --namespace %NAMESPACE% --set images.airflow.repository=airflow-local-build --set images.airflow.tag=0.0.1 --timeout 10m30s
kubectl port-forward svc/%RELEASE_NAME%-webserver 8080:8080 --namespace %NAMESPACE%