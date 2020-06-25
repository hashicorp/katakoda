mkdir -p ~/terraform-sentinel
git clone https://github.com/hashicorp/hashicorp-learn-sentinel-katacoda.git ~/terraform-sentinel
cd ~/terraform-sentinel
rm restrict-s3-buckets.sentinel

mv ~/restrict-s3-buckets.sentinel .

clear

echo "Ready!"
