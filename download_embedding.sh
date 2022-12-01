export embed_dim=300 #Must be declared. #available dims are 50, 100, 200 and 500 
export embed_file_name=glove.6B."$embed_dim"d.txt #Must be decleared as it will be used during training
# For refrencess please visit https://nlp.stanford.edu/projects/glove/ 
# There are more trained embeddings that were trained on more corpus, check prev site for more.

wget -P /tmp http://nlp.stanford.edu/data/glove.6B.zip

unzip -q /tmp/glove.6B.zip

cp /tmp/"$embed_file_name" /opt/app/model/artifacts/trained_embed/



echo 'export embed_dim=$embed_dim' >> ~/.profile #To keep env variable on the system after restarting
echo 'export embed_file_name=$embed_file_name' >> ~/.profile #To keep env variable on the system after restarting

