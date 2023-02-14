variable "domain_name" {
  type        = string
  description = "The domain name for the webiste"
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix"
}

variable "bucket_name_www" {
  type        = string
  description = "The name of the bucket with the www. prefix"
}


variable "common_tags" {
  description = "Common tags if you want applied to all compents"

}

variable "buckets" {
  type    = list(string)
  default = ["akilblanchard.com", "www.akilblanchard.com"]
}