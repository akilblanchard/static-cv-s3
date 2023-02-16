resource "aws_acm_certificate" "ssl_certificate" {
  domain_name       = "akilblanchard.com"
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method = "DNS"
}