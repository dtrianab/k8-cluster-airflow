FROM apache/airflow

# Files directory (dags)
COPY . .

#Dependencies
RUN pip3 install -r requirements.txt
RUN pip3 install --upgrade pip
RUN pip3 install newspaper3k