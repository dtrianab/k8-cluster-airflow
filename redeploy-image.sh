docker build --pull --tag airflow-local-build:0.0.1 .
kind load docker-image airflow-local-build:0.0.1
helm upgrade airflow apache-airflow/airflow --namespace $NAMESPACE --set images.airflow.repository=airflow-local-build--set images.airflow.tag=0.0.1 --timeout 10m30s