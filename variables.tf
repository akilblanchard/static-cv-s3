variable "domain_name" {
  type        = string
  description = "The domain name for the webiste"
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
}


variable "common_tags" {
  description = "Common tags if you want applied to all compents"

}