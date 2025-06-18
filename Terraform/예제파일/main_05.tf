terraform {
        required_providers {
                aws = {
                        source = "hashicorp/aws"
                        version = "~> 5.100.0"
                }
        }
        required_version = ">= 1.4"
}

provider "aws" {
        region = "ap-northeast-2"
}

resource "aws_instance" "app_server" {

        ami = "ami-0662f4965dfc70aca"
        instance_type = "t2.micro"

        tags = {
                 Name = "terraform-ubuntu2404"
        }
}
