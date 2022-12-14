FROM tensorflow/tensorflow:2.11.0-gpu

RUN apt-get -y update && \
        apt-get -y install gcc mono-mcs && \
        apt-get install -y --no-install-recommends \
         wget \
         nginx \
         ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ARG embed_dim=50 

ENV embed_dim=${embed_dim} 
ENV embed_file_name=glove.6B."$embed_dim"d.txt 

# For referencess please visit https://nlp.stanford.edu/projects/glove/ 
# There are more trained embeddings that were trained on more corpus, check prev site for more.

RUN wget -P /tmp http://nlp.stanford.edu/data/glove.6B.zip
RUN unzip /tmp/glove.6B.zip -d /tmp/


COPY ./requirements.txt .
RUN pip install -r requirements.txt 

RUN mkdir -p /opt/app/Utils/pretrained_embed
RUN mv /tmp/"$embed_file_name" /opt/app/Utils/pretrained_embed
RUN echo 'export embed_dim=$embed_dim' >> /root/.bashrc  #To keep env variable on the system after restarting
RUN echo 'export embed_file_name=$embed_file_name' >> /root/.bashrc #To keep env variable on the system after restarting

COPY app ./opt/app

WORKDIR /opt/app



ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PATH="/opt/app:${PATH}"



RUN chmod +x train &&\
    chmod +x predict &&\
    chmod +x serve 

RUN chown -R 1000:1000 /opt/app/  && \
    chown -R 1000:1000 /var/log/nginx/  && \
    chown -R 1000:1000 /var/lib/nginx/

USER 1000