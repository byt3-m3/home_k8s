provider "helm" {
  kubernetes {
    config_context = "docker-desktop"
    config_path = "~/.kube/config"
  }
}


provider "kubernetes" {

#  config_path = "~/.kube/config"
#  config_context = "docker-desktop"
  config_path = "../../k8s/home_cluster_config.yaml"
  config_context = "microk8s"
}