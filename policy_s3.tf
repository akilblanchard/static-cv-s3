#s3Policy
resource "aws_s3_bucket_policy" "public_read_access" {
  for_each = toset(var.buckets)
  bucket   = each.key
  policy   = <<POLICY

{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
	    "Principal": "*",
      "Action": [ "s3:GetObject","s3:PutObject" ],
      "Resource": [
        arn:aws:s3:::${aws_s3_bucket.www_bucket.arn},
        arn:aws:s3:::${aws_s3_bucket.root_bucket.arn}/*
        ]
  
    }
  ]
POLICY
}