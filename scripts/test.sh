#! /bin/bash
#clone repo
echo "Cloning"
git clone --branch main https://github.com/qatrainingjaguila/CNEDevOps.git
cd CNEDevOps
#run app
echo ${DATABASE_URI}
docker-compose build
docker-compose up -d -E DATABASE_URI=${DATABASE_URI} -E TEST_DATABASE_URI=${TEST_DATABASE_URI} -E SECRET_KEY=${SECRET_KEY}
#docker exec run pytest
echo "Running tests. Ensure Database URIs have been set"
sudo docker exec frontend bash -c "pytest tests/ --cov application"
sudo docker exec backend bash -c "pytest tests/ --cov application"
#clean up
sudo docker-compose down
cd ..
ls
rm -rf CNEDevOps
ls
#exit