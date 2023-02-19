# Cloudfront distribution for main s3 site.

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {}
resource "aws_cloudfront_distribution" "website_bucket" {
  origin {
    domain_name = aws_s3_bucket.website_bucket.website_endpoint
    origin_id   = var.bucket_name
    
  custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
    

  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = ["${var.domain_name}"]



  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.bucket_name

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 8400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

   # Distributes content to US and Europe
  price_class = "PriceClass_100"

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.certs.arn
    ssl_support_method       = "sni-only"
    }

  tags = var.common_tags
}