#! /bin/bash
echo "Pushing images to Docker. Ensure user is added to docker group and logged in"
cd backend
sudo docker build -t qatrainingjaguila/my-backenddd .
cd ..
cd frontend
sudo docker build -t qatrainingjaguila/my-frontendd .
cd ..
sudo docker push qatrainingjaguila/my-backenddd
sudo docker push qatrainingjaguila/my-frontendd