resource "aws_acm_certificate" "certs" {
  domain_name       = var.domain_name
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}




#create a record set in route 53 for domain validation
resource "aws_route53_record" "certs_validation" {
  for_each = {
    for dvo in aws_acm_certificate.certs.domain_validation_options : dvo.domain_name => {
      name = dvo.resource_record_name
      record = dvo.resource_record_value
      type = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name = each.value.name
  records = [each.value.record]
  ttl = 60
  type = each.value.type
  zone_id = aws_route53_zone.main.zone_id
}

#validate cert
resource "aws_acm_certificate_validation" "acm_certs_validation" {
  certificate_arn = aws_acm_certificate.certs.arn
  validation_record_fqdns = [ for record in aws_route53_record.certs_validation : record.fqdn]
  
}