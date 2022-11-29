resource "kubernetes_namespace" "media-services" {
  metadata {
    name = "media-services"
  }
}
