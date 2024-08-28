#!/bin/bash

kind delete cluster && kind create cluster --config - <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
  - role: worker
EOF
kubectl cluster-info --context kind-kind

kubectl apply --server-side -f bundle.yaml

kustomize build . | kubectl apply --server-side -f -

# sleep 10

# kubectl rollout status statefulset prometheus-prometheus --timeout=600s
# kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=prometheus --timeout 300s

# kubectl port-forward svc/prometheus-operated 9090:9090 > /dev/null 2>&1 &

NODE_PORT=$(kubectl get svc prometheus -o jsonpath='{.spec.ports[0].nodePort}')
NODE_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')

url="http://${NODE_IP}:${NODE_PORT}"

sleep 60
curl "$url/-/healthy"

printf "\nLoading resources... this may take a minute."
printf "\nMetrics URL: "
echo -e "\e[4m$url/targets\e[0m\n"

printf "\nConsole Templates URL: "
echo -e "\e[4m$url/consoles/test.html\e[0m\n"
