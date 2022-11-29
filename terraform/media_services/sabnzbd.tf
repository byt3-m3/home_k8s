resource "kubernetes_deployment" "sabnzbd-server" {
  metadata {
    name      = "sabnzbd-server"
    namespace = "media-services"
  }
  depends_on = [
    kubernetes_namespace.media-services
  ]
  spec {
    replicas = 1
    selector {
      match_labels = {
        service_name = "sabnzbd-server"
      }
    }
    template {
      metadata {
        labels = {
          service_name = "sabnzbd-server"
        }
      }
      spec {
        container {
          name  = "sabnzbd-server"
          image = "linuxserver/sabnzbd:nightly-e9578d9a-ls97"
          port {
            container_port = 8080
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
