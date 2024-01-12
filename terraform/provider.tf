terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.21"
    }
  }

  backend "local" {
    path = ".tfstate"
  }

  required_version = ">= 1.6.2"
}

provider "aws" {
  region = local.region
}
