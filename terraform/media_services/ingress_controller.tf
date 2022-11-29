resource "helm_release" "nginx-ingress-controller" {
  chart      = "ingress-nginx/ingress-nginx"
  version    = "4.4.0"
  name       = "home-ingress-controller"
  namespace  = "ingress-nginx"
  depends_on = [
    kubernetes_namespace.ingress-nginx
  ]

  set {
    name  = "controller.ingressClassResource.name"
    value = "home-ingress-controller"
  }

  set {
    name  = "controller.ingressClassResource.controllerValue"
    value = "k8s.io/home-ingress-controller"
  }

  set {
    name  = "controller.ingressClass"
    value = "home-ingress-controller"
  }
}