#records for bucket
resource "aws_route53_zone" "main" {
  name = var.domain_name
  tags = var.common_tags
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.website_bucket.domain_name
    zone_id                = aws_cloudfront_distribution.website_bucket.hosted_zone_id
    evaluate_target_health = false
  }
}
