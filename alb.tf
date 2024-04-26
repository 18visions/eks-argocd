resource "aws_lb" "argocd" {
  name               = "argocd-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.argocd.id]
  subnets            = ["subnet-f3be15b9", "subnet-1eec0b42", "subnet-1eec0b42"]

  enable_deletion_protection = false

  tags = {
    Name = "argocd"
  }
}

#output "kubeconfig" {
#  value = module.eks.kubeconfig_filename
#}
