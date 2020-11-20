#! /bin/bash
#clone repo
echo "Cloning"
git clone --branch main https://github.com/qatrainingjaguila/CNEDevOps.git
cd CNEDevOps
#run app
sudo docker-compose up -d
#docker exec run pytest
echo "Running tests. Ensure Database URIs have been set"
sudo docker exec frontend bash -c "pytest tests/ --cov application"
sudo docker exec backend bash -c "pytest tests/ --cov application"
#clean up
cd ..
ls
rm -rf CNEDevOps
ls
#exit