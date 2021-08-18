terraform {
  required_version = ">= 0.15.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

   backend "s3" {
    bucket = "mybucket789456123"
    key    = "abc/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
   region     = var.aws_region
   profile    = var.aws_profile
}

provider "aws" {
   alias      = "east"
   region     = var.aws_region
   profile    = var.aws_profile
}


resource "aws_instance" "my_ec2" {

   ami           = "ami-0dc2d3e4c0f9ebd18"
   instance_type = var.my_instance_type
   count         = var.instance_count

   
   tags = {
     Name = "myterra_ec2 ${count.index+1}"
   }

    /* provisioner "local-exec" {
    command = "touch hello-test.txt"
    interpreter = ["PowerShell", "-Command"]
  }*/
}

data "aws_vpc" "ibm" {
  filter {
    name = "tag:Name"
    values = ["ibm"]
  }
}

resource "aws_subnet" "ibm_subnet" {
  vpc_id            = data.aws_vpc.ibm.id
  availability_zone = "us-east-1a"
  cidr_block        = cidrsubnet(data.aws_vpc.ibm.cidr_block, 8, 1)
}

resource "aws_security_group" "allow_ibm_sg" {
  name        = "ibm_sg"
  description = "Allow http & https inbound traffic"
  vpc_id      = data.aws_vpc.ibm.id

   dynamic "ingress" {
      for_each = local.ingress_rules

      content {
         description = ingress.value.description
         from_port   = ingress.value.port
         to_port     = ingress.value.port
         protocol    = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
      
      }
   }
/*
  ingress {
    description      = "port 443"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

   ingress {
    description      = "port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
*/
}


/*
lifecycle {
   create_before_destroy = true
}*/

/*
resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}*/

// or
/*
resource "aws_iam_user" "example" {
  for_each = var.user_names
  name  = each.value
}*/



resource "aws_iam_user" "example" {
  for_each = var.iam_users
  name  = each.value
}