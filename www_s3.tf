#cv_bucket
resource "aws_s3_bucket" "www_bucket" {
  bucket = "www.{var.bucket_name}"
  acl    = "public-read"
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  tags = {
    Enviroment = "development"
    name       = "cv-bucket"
  }
}
resource "aws_s3_bucket_versioning" "www_bucket" {
  bucket = aws_s3_bucket.www_bucket.id
  versioning_configuration {
    status = "Enabled"
  }

}


#StaticWebsiteFiles
resource "aws_s3_bucket_object" "html" {
  source = "~/repos/static-cv-s3-terraform/index.html"

  bucket       = aws_s3_bucket.www_bucket.bucket
  key          = "cv_index_html"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "css" {
  source = "~/repos/static-cv-s3-terraform/style.css"

  bucket       = aws_s3_bucket.www_bucket.bucket
  key          = "cv_style_css"
  content_type = "text/css"
}


