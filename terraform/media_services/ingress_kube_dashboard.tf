resource "kubernetes_ingress_v1" "kube-dashboard" {
  metadata {
    name        = "kube-dashboard"
    namespace   = "kube-system"
    annotations = {
      #     "nginx.ingress.kubernetes.io/rewrite-target": "/$2"
    }
  }
  spec {
    ingress_class_name = "home-ingress-controller"
    rule {
      host = "kube-dashboard.home.local"
      http {

        path {

          path = "/"
          backend {

            service {
              name = "kubernetes-dashboard"
              port {
                number = 443
              }
            }
          }
        }

      }
    }
  }
}