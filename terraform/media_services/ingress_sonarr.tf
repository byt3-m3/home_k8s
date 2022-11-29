resource "kubernetes_ingress_v1" "sonarr" {
  metadata {
    name        = "sonarr"
    namespace   = "media-services"
    annotations = {
      #     "nginx.ingress.kubernetes.io/rewrite-target": "/$2"
    }
  }
  spec {
    ingress_class_name = "home-ingress-controller"
    rule {
      host = "sonarr.home.local"
      http {

        path {

          path = "/"
          backend {

            service {
              name = kubernetes_service.sonarr-server.metadata[0].name
              port {
                number = 8989
              }
            }
          }
        }

      }
    }
  }
}