
#requests public cert fro, acm
resource "aws_acm_certificate" "certificate" {
  domain_name               = "akilblanchard.com"
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

#get details about route 53 hosted zone
data "aws_route53_zone" "route53_zone" {
  name         = "akilblanchard.com"
  private_zone = false
}


#create a record set in route 53 for domain validation
resource "aws_route53_record" "route53_record" {
  for_each = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }


  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.route53_zone.zone_id
}

#validate acm certificates
resource "aws_acm_certificate_validation" "aws_acm_certificate_validation" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.route53_record : record.fqdn]
}
