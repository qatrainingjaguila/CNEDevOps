#! /bin/bash
echo "Pushing images to Docker. Ensure user is added to docker group and logged in"
cd backend
docker build -t qatrainingjaguila/mybackenddd .