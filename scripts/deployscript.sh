#!/bin/bash

echo "calling deployscript. Ensure project namespace and secret.yaml exist"
ls
kubectl get namespace
sudo mv secret.yaml /K8s
#kubectl apply
cd K8S
ls
cd ..
cp secret.yaml Project/K8S
kubectl apply -f nginx-conf.yaml -n project
kubectl apply -f secret.yaml -n project
kubectl apply -f backend-app.yaml -f backend-cip.yaml -f flask-app.yaml -f flask-cip.yaml -f nginx.yaml -f nginx-lb.yaml