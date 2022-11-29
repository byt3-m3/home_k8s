resource "kubernetes_persistent_volume" "plex-data" {
  metadata {
    name = "plex-data"

  }
  spec {
    storage_class_name = "microk8s-hostpath"
    access_modes = [
    "ReadWriteMany"
    ]
    capacity     = {
      storage: "300G"
    }

    persistent_volume_source {
      nfs {
        path   = "/volume1/plex_data"
        server = "192.168.1.12"
        read_only = "false"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "plex-data" {
  metadata {
    name = "plex-data"
    namespace = "media-services"
  }
  spec {
    storage_class_name = ""
    access_modes = [
    "ReadWriteMany"
    ]

    volume_name = kubernetes_persistent_volume.plex-data.metadata[0].name
    resources {

      requests = {
        storage: "300G"
      }
    }
  }
}

