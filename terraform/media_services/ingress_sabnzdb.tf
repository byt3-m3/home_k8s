resource "kubernetes_ingress_v1" "sabnzbd" {
  metadata {
    name        = "sabnzbd"
    namespace   = "media-services"
    annotations = {
      #     "nginx.ingress.kubernetes.io/rewrite-target": "/$2"
    }
  }
  spec {
    ingress_class_name = "home-ingress-controller"
    rule {
      host = "sabnzbd.home.local"
      http {

        path {

          path = "/"
          backend {

            service {
              name = kubernetes_service.sabnzbd-server.metadata[0].name
              port {
                number = 8080
              }
            }
          }
        }

      }
    }
  }
}