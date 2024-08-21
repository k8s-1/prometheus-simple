#!/bin/bash
kustomize build . | kubectl create -f -
kubectl port-forward svc/prometheus-operated 9090:9090
