terraform {
  required_version = ">= 1.0"

  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.29"
    }

    sql = {
      source  = "paultyng/sql"
      version = "0.4.0"
    }
  }
}
