resource "kubernetes_role" "ingress_manager" {
  metadata {
    name      = "ingress-manager"
    namespace = "argocd"
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses"]
    verbs      = ["get", "list", "watch", "create", "update", "delete"]
  }
}


resource "kubernetes_ingress_v1" "this" {
    metadata {
        name      = "argocd-ingress"
        namespace = "argocd"
        annotations = {
        "kubernetes.io/ingress.class" = "nginx"
        "nginx.ingress.kubernetes.io/backend-protocol" = "HTTPS"
        }
    }
    spec {
        ingress_class_name = "nginx"
        rule {
        host = "argocd.iworksometimes.com"
        http {
            path {
            path = "/"
            backend {
                service {
                name = "argocd-server"
                port {
                    number = 443
                }
            }
            }
        }
        }
    }
  
}
}