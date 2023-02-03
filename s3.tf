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

#s3 policy
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
      "Action": [ "s3:*" ],
      "Resource": [
        "${aws_s3_bucket.cv_bucket.arn}",
        "${aws_s3_bucket.cv_bucket.arn}/*"
      ]
    }
  ]
}
POLICY
}



