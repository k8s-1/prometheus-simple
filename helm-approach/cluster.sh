#!/bin/bash
kind delete cluster
kind create cluster --config - <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
kubeadmConfigPatches:
- |-
  kind: ClusterConfiguration
  # configure controller-manager bind address
  controllerManager:
    extraArgs:
      bind-address: 0.0.0.0
  # configure etcd metrics listen address
  etcd:
    local:
      extraArgs:
        listen-metrics-urls: http://0.0.0.0:2381
  # configure scheduler bind address
  scheduler:
    extraArgs:
      bind-address: 0.0.0.0
- |-
  kind: KubeProxyConfiguration
  # configure proxy metrics bind address
  metricsBindAddress: 0.0.0.0
nodes:
- role: control-plane
- role: worker
EOF

helm upgrade --install --wait --timeout 15m \
  --namespace monitoring --create-namespace \
  --repo https://prometheus-community.github.io/helm-charts \
  kube-prometheus-stack kube-prometheus-stack --values - <<EOF
kubeEtcd:
  service:
    targetPort: 2381
EOF
