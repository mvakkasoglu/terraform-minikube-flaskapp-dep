provider "kubernetes" {
  config_context = "minikube"
  config_path = "~/.kube/config"
}

locals {
  flaskapp_labels = {
    App  = "flaskapp"
  }
}

resource "kubernetes_deployment" "flaskapp" {
  metadata {
    name   = "flaskapp"
    labels = local.flaskapp_labels
  }
  spec {
    replicas = 1
    selector {
      match_labels = local.flaskapp_labels
    }
    template {
      metadata {
        labels = local.flaskapp_labels
      }
      spec {
        container {
          image = "vakkasoglu/capstone-project"
          name  = "flaskapp"
          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "flaskapp-service" {
  metadata {
    name = "flaskapp-service"
  }
  spec {
    selector = local.flaskapp_labels
    port {
      port        = 5000
      target_port = 5000
      node_port   = 32000
    }
    type = "NodePort"
  }
}
