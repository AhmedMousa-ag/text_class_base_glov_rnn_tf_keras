
# For referencess please visit https://nlp.stanford.edu/projects/glove/ 
# There are more trained embeddings that were trained on more corpus, check prev site for more.

wget -P /tmp http://nlp.stanford.edu/data/glove.6B.zip


unzip /tmp/glove.6B.zip -d /tmp/


mkdir -p /opt/app/model/artifacts/trained_embed/


cp /tmp/"$embed_file_name" /opt/app/model/artifacts/trained_embed/


echo 'export embed_dim=$embed_dim' >> /root/.bashrc  #To keep env variable on the system after restarting
echo 'export embed_file_name=$embed_file_name' >> /root/.bashrc #To keep env variable on the system after restarting

