mkdir -p /opt/app/model/artifacts/trained_embed/


cp /tmp/"$embed_file_name" /opt/app/model/artifacts/trained_embed/


echo 'export embed_dim=$embed_dim' >> /root/.bashrc  #To keep env variable on the system after restarting
echo 'export embed_file_name=$embed_file_name' >> /root/.bashrc #To keep env variable on the system after restarting