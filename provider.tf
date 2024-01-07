terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
   
   backend "s3" {
    bucket = "dev-venkat-aws-state"
    key    = "provisioners"
    region = "us-east-1"
    dynamodb_table = "devops-aws-venkat-state-locking"
}
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}