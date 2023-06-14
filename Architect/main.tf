terraform {
  required_version = ">= 0.15.5"

  backend "s3" {
    bucket         = "frontend-build-standark"
    key            = "build/terraform.tfstate"
    region         = "ap-northeast-1"
    profile        = "chevanhoang"
    dynamodb_table = "TerraformStateLockTable"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.8.0"
    }
  }
}

provider "aws" {
  region  = "ap-northeast-1"
  profile = "chevanhoang"
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}