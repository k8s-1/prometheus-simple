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
