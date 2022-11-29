resource "kubernetes_ingress_v1" "grafana" {
  metadata {
    name        = "grafana"
    namespace   = "home-monitoring"
    annotations = {
      #     "nginx.ingress.kubernetes.io/rewrite-target": "/$2"
    }
  }
  spec {
    ingress_class_name = "home-ingress-controller"
    rule {
      host = "grafana.home.local"
      http {

        path {

          path = "/"
          backend {

            service {
              name = "prometheus-deployment-grafana"
              port {
                number = 80
              }
            }
          }
        }

      }
    }
  }
}