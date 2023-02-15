#S3 bucket for directing www. traffic
resource "aws_s3_bucket" "root_bucket" {
  bucket = var.bucket_name
  policy = templatefile("s3-policy.json", { bucket = var.bucket_name })
  acl    = "public-read"


  website {
    redirect_all_requests_to = "https://www.{var.domain_name}"
  }
}
