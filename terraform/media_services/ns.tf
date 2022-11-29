resource "kubernetes_namespace" "media-services" {
  metadata {
    name = "media-services"
  }
}

resource "kubernetes_namespace" "ingress-nginx" {
  metadata {
    name = "ingress-nginx"
  }
}