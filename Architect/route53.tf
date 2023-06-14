#######################-Import R53-#######################
data "aws_route53_zone" "hostedzone" {
  name = "hoangdevops.site."
}

#######################-Create Record Alias CloudFront-#######################
resource "aws_route53_record" "route53_record_alias_frontend" {
  zone_id = data.aws_route53_zone.hostedzone.zone_id
  name    = "fe.${var.domain_name}"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cloudfront_fe.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront_fe.hosted_zone_id
    evaluate_target_health = false
  }
}