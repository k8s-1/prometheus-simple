#!/bin/bash
kustomize build . | kubectl delete -f -
sleep 30 # wait for operator to cleanup resources
kubectl delete -f bundle.yaml
