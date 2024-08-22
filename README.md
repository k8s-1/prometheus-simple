# Intro
* Prometheus collects kubernetes metrics and can visualize them with queries, no need for a grafana dashboard
* Requires RBAC prometheus user to talk to API server
* Uses prometheus-operator to do the heavylifting of config

# Simple & quick monitoring
* Good for setting up a quick monitoring solution
* Additional resources are required e.g. kube-state-metrics to actually enable
prometheus to scrape the monitoring data

# Install

## Latest prometheus-operator bundle
```
LATEST=$(curl -s https://api.github.com/repos/prometheus-operator/prometheus-operator/releases/latest | jq -cr .tag_name)
curl -sL https://github.com/prometheus-operator/prometheus-operator/releases/download/${LATEST}/bundle.yaml -O bundle.yaml
```

# Explanation
* bundle.yaml includes the prometheus operator that helps setup prometheus
* rbac is necessary for prometheus service account to be able to talk to api-server
* prometheus-instance.yaml includes a prometheus instance for prometheus operator to setup
* example-pod|svc-monitor.yaml is picked up by the prometheus instance, it's a CRD that defines a resource group to be monitored
    * instance and monitor CRD need matching labels
    * monitor CRD requires resources deployments/pods to expose a metric endpoint, name needs to match with what is defined in CRD, sometimes a container doesn't have a metrics port and needs a sidecar -> see pod nginx example for sidecar implementation
    ```
    CRD >>>
    podMetricsEndpoints:
      - port: metrics-port
    container spec >>>
    - name: ...
        - containerPort: 9113  # Exporter port for metrics
          name: metrics-port
    ```
