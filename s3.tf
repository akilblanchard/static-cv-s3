#cv_bucket
resource "aws_s3_bucket" "cv_bucket" {
  bucket = "akil-blanchard.com"
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
resource "aws_s3_bucket_versioning" "cv_bucket" {
  bucket = aws_s3_bucket.cv_bucket.id
  versioning_configuration {
    status = "Enabled"
  }

}


#StaticWebsiteFiles
resource "aws_s3_bucket_object" "html" {
  source = "~/repos/static-cv-s3-terraform/index.html"

  bucket       = aws_s3_bucket.cv_bucket.bucket
  key          = "new_object_key"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "css" {
  source = "~/repos/static-cv-s3-terraform/style.css"

  bucket       = aws_s3_bucket.cv_bucket.bucket
  key          = "new_object_key"
  content_type = "text/css"
}


#s3Policy
resource "aws_s3_bucket_policy" "public_read_access" {
  bucket = aws_s3_bucket.cv_bucket.id
  policy = <<POLICY

{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
	    "Principal": "*",
      "Action": [ "s3:GetObject" ],
      "Resource": [
        "${aws_s3_bucket.cv_bucket.arn}",
        "${aws_s3_bucket.cv_bucket.arn}/*"
      ]
    }
  ]
}
POLICY
}










































