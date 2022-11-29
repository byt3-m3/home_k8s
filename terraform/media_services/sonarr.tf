resource "kubernetes_service" "sonarr-server" {
  metadata {
    name = "sonarr-svc"
    namespace = "media-services"
  }
  spec {
       port {

      protocol    = "TCP"
      port        = 8989
      target_port = 8989

    }
    selector = { service_name = "sonarr-server" }
    type     = "ClusterIP"
  }
}

#resource "kubernetes_service" "sonarr-server-lb" {
#  metadata {
#    name = "sonarr-svc-lb"
#    namespace = "media-services"
#  }
#  spec {
#       port {
#
#      protocol    = "TCP"
#      port        = 8989
#      target_port = 8989
#
#    }
#    selector = { service_name = "sonarr-server" }
#    type     = "LoadBalancer"
#  }
#}

resource "kubernetes_deployment" "sonarr-server" {
  metadata {
    name      = "sonarr-server"
    namespace = "media-services"
  }
  depends_on = [
    kubernetes_namespace.media-services
  ]
  spec {
    replicas = 1
    selector {
      match_labels = {
        service_name = "sonarr-server"
      }
    }
    template {
      metadata {
        labels = {
          service_name = "sonarr-server"
        }
      }
      spec {
        container {
          name  = "sonarr-server"
          image = "linuxserver/sonarr:4.0.0-v4"
          port {
            container_port = 8989
          }
          volume_mount {
            mount_path = "/mnt/movies"
            name       = "movies-mount-qnap"
          }
          volume_mount {
            mount_path = "/mnt/tv_shows"
            name       = "tv-mount-qnap"
          }
          volume_mount {
            mount_path = "/mnt/movies_2"
            name       = "movies-mount-synology"
          }
          volume_mount {
            mount_path = "/mnt/tv_shows_2"
            name       = "tv-mount-synology"
          }
        }
        volume {
          name = "movies-mount-qnap"
          nfs {
            path   = "/movies"
            server = "192.168.1.4"
          }
        }

        volume {
          name = "tv-mount-qnap"
          nfs {
            path   = "/tv_shows"
            server = "192.168.1.4"
          }
        }
        volume {
          name = "movies-mount-synology"
          nfs {
            path   = "/volume1/movies"
            server = "192.168.1.12"
          }
        }

        volume {
          name = "tv-mount-synology"
          nfs {
            path   = "/volume1/tv_shows"
            server = "192.168.1.12"
          }
        }
      }

    }

  }

}
