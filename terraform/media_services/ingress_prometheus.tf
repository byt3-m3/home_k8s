resource "kubernetes_ingress_v1" "prometheus" {
  metadata {
    name        = "prometheus"
    namespace   = "home-monitoring"
    annotations = {
      #     "nginx.ingress.kubernetes.io/rewrite-target": "/$2"
    }
  }
  spec {
    ingress_class_name = "home-ingress-controller"
    rule {
      host = "prometheus.home.local"
      http {

        path {

          path = "/"
          backend {

            service {
              name = "prometheus-deployment-kube-prometheus"
              port {
                number = 9090
              }
            }
          }
        }

      }
    }
  }
}