#!/bin/bash
kubectl apply --server-side -f bundle.yaml

kustomize build . | kubectl apply --server-side -f -

kubectl port-forward svc/prometheus-k8s 9090:9090 > /dev/null 2>&1 &

printf "\nMetrics are being monitored:"
url="http://localhost:9090/targets"
echo -e "\e[4m$url\e[0m"
