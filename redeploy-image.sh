export NAMESPACE=airflow-cluster
export RELEASE_NAME=airflow
export IMAGE=airflow-local-build
export TAG=0.0.1
docker build --pull --$IMAGE:$TAG .
kind load docker-image $IMAGE:$TAG
helm upgrade airflow apache-airflow/airflow --namespace $NAMESPACE --set images.airflow.repository=$IMAGE --set images.airflow.tag=$TAG --timeout 10m30s