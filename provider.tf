terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        # version = "5.14.0"
    }
  }
}

provider "aws" {
    region = "eu-west-1"
    shared_credentials_files = ["~/.aws/credentials"]
    profile = "default"
}