FROM apache/airflow

# Files directory (dags) and depencies list
COPY . .
#COPY requirements.txt .

# install Dependencies
RUN pip3 install -r requirements.txt
RUN pip3 install --upgrade pip
RUN pip3 install newspaper3k