resource "kubernetes_ingress_v1" "radarr" {
  metadata {
    name        = "radarr"
    namespace   = "media-services"
    annotations = {
      #     "nginx.ingress.kubernetes.io/rewrite-target": "/$2"
    }
  }
  spec {
    ingress_class_name = "home-ingress-controller"
    rule {
      host = "radarr.home.local"
      http {

        path {

          path = "/"
          backend {

            service {
              name = kubernetes_service.radarr-server.metadata[0].name
              port {
                number = 7878
              }
            }
          }
        }

      }
    }
  }
}