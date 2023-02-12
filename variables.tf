variable "domain_name" {
  type        = string
  description = "The domain name for the webiste"
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the wwwi. prefix"
}

variable "common_tags" {
  description = "Common tags if you want applied to all compents"

}

variable "buckets" {
  type    = list(string)
  default = ["www_bucket", "root_bucket"]
}