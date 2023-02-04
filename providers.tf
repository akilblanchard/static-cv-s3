terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}



provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "/Users/killy/.aws/credentials"
  profile                 = "ablanchard"
}

provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"

}