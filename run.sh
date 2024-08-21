#!/bin/bash
kustomize build . | kubectl apply -f -
kubectl port-forward svc/prometheus-operated 9090:9090
