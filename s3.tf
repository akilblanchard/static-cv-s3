resource "aws_s3_bucket" "cv_bucket" {
  bucket = "akil-blanchard.com"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}