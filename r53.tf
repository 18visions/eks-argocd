# Fetch the existing hosted zone
data "aws_route53_zone" "existing" {
  name = "iworksometimes.com."
}
resource "aws_route53_record" "argocd" {
  zone_id = data.aws_route53_zone.existing.zone_id
  name    = "argocd.iworksometimes.com"
  type    = "A"

  alias {
    name                   = aws_lb.argocd.dns_name
    zone_id                = aws_lb.argocd.zone_id
    evaluate_target_health = true
  }
}
