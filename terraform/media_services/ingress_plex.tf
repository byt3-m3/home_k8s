resource "kubernetes_ingress_v1" "plex" {
  metadata {
    name        = "plex"
    namespace   = "media-services"
    annotations = {
      #     "nginx.ingress.kubernetes.io/rewrite-target": "/$2"
    }
  }
  spec {
    ingress_class_name = "home-ingress-controller"
    rule {
      host = "plex.home.local"
      http {

        path {

          path = "/"
          backend {

            service {
              name = kubernetes_service.plex-server.metadata[0].name
              port {
                number = 32400
              }
            }
          }
        }

      }
    }
  }
}