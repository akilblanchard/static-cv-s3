#aws-static-site-terraform

A proof of concept of deploying a static website in in aws via Terraform.

Hosting static websites on S3 is cost effective and requires very little configuration and ongoing management.
Utilizing Terraform to do this allows for infrastructure to be easily provisioned, taken down and makes it simpler to expand on this project in the future if need be.

This project will provision : 

An s3 bucket to host the website's files

SSL wildcard certificate validated for the domain with automatic renewal

Cloudfront distribution

Route 53 records pointed at to the Cloudfront distributions
