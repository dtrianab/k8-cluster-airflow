FROM apache/airflow
COPY ./DAGS_GC ./dags
RUN pip3 install --upgrade pip
RUN pip3 install newspaper3k
COPY requirements.txt .
RUN pip3 install -r requirements.txt