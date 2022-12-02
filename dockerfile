FROM tensorflow/tensorflow:2.11.0-gpu

RUN apt-get -y update && \
        apt-get -y install gcc mono-mcs && \
        apt-get install -y --no-install-recommends \
         wget \
         nginx \
         ca-certificates \
    && rm -rf /var/lib/apt/lists/*



COPY ./requirements.txt .
RUN pip install -r requirements.txt 


ENV embed_dim=300 
ENV embed_file_name=glove.6B."$embed_dim"d.txt 

COPY ./download_embedding.sh .
RUN ./download_embedding.sh 

COPY app ./opt/app

WORKDIR /opt/app


ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PATH="/opt/app:${PATH}"



RUN chmod +x train &&\
    chmod +x predict &&\
    chmod +x serve 

