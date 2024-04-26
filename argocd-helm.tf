resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "3.26.3"
  namespace  = kubernetes_namespace.argocd.metadata[0].name

  set {
    name  = "server.ingress.enabled"
    value = "true"
  }

  set {
    name  = "server.ingress.hosts[0]"
    value = "argocd.iworksometimes.com"
  }

  set {
    name  = "server.ingress.annotations.kubernetes\\.io/ingress.class"
    value = "nginx"
  }
}
