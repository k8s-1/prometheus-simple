#!/bin/bash
kubectl apply -f bundle.yaml --server-side

kustomize build . | kubectl create -f -

kubectl port-forward svc/prometheus-k8s 9090:9090 > /dev/null 2>&1 &

printf "\nMetrics are being monitored:"
url="http://localhost:9090/targets"
echo -e "\e[4m$url\e[0m"
