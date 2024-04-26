resource "kubernetes_namespace" "ingress-nginx" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  namespace  = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.0.6"  // Check for the latest version in the Helm repository

  set {
    name  = "controller.publishService.enabled"
    value = "true"
  }
}

#source "kubernetes_ingress" "argocd" {
#metadata {
#  name      = "argocd-ingress"
#  namespace = "argocd"
#  annotations = {
#    "kubernetes.io/ingress.class" = "nginx"
#    "nginx.ingress.kubernetes.io/backend-protocol" = "HTTPS"  # Only if ArgoCD is served over HTTPS
#  }
#}
#spec {
#  ingress_class_name = "nginx"
#  rule {
#    host = "argocd.iworksometimes.com"
#    http {
#      path {
#        path = "/"
#        backend {
#          service_name = "argocd-server"
#          service_port = 443
#          }
#        }
#      }
#    }
#  }
#}
#
## Ensures the use of the v1 API
##api_version = "networking.k8s.io/v1"
  

