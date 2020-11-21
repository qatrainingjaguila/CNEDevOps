#!/bin/bash

echo "calling deployscript. Ensure project namespace and secret.yaml exist in K8S"
cd K8S
# Running kubernetes deployment commands
kubectl delete deployment flask-app -n project
kubectl delete deployment backend -n project
kubectl apply -f nginx-conf.yaml -n project
kubectl apply -f backend-app.yaml -f backend-cip.yaml -f flask-app.yaml -f flask-cip.yaml -f nginx.yaml -f nginx-lb.yaml
#retrieving loadbalancer information
kubectl describe service/nginx-loadbalancer -n project