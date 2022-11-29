resource "helm_release" "prometheus-deployment" {
  chart      = "prometheus-community/kube-prometheus-stack"
  name       = "prometheus-deployment"
  version = "42.1.0"
  namespace  = "home-monitoring"
  depends_on = [
    kubernetes_namespace.monitoring-ns
  ]

  set {
    name  = "nodeExporter.enabled"
    value = "false"
  }

  set {
    name  = "defaultRules.create"
    value = "false"
  }

  set {
    name  = "prometheus.serviceMonitor.enabled"
    value = "true"
  }

  set {
    name  = "prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues"
    value = "false"
  }

  set {
    name  = "prometheus.prometheusSpec.serviceMonitorSelector"
    value = ""
  }

}

resource "kubernetes_namespace" "monitoring-ns" {
  metadata {
    name = "home-monitoring"
  }
}