resource "kubernetes_role_binding" "ingress_manager_binding" {
  metadata {
    name      = "ingress-manager-binding"
    namespace = "argocd"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "argocd-server"
    namespace = "argocd"
  }

  role_ref {
    kind      = "Role"
    name      = kubernetes_role.ingress_manager.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}
