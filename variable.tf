variable "aws_region" {
  default =  "us-east-1"
}

variable "aws_profile" {
  type    = string
  default = "Terraform"
}
variable "my_instance_type" {
   description = "Instance type t2.micro"
   type        = string
}

variable "instance_tags" {
  type = object({
    Name = string
    foo  = number
  })
}
/*
variable "foobar" {
  type = list(string)
}
*/
variable "instance_count" {
  description = "EC2 instance count"
  type        = number
}  

variable "vpc_id" {
  default = ""
}

locals {
  ingress_rules = [{
     port        = 443
     description = "port 443"
  },
  {
     port        = 80
     description = "port 80"
  }]
}
/*
variable "user_names" {
  description = "IAM usernames"
  type        = list(string)
  default     = ["user1", "user2", "user3"]
}*/

//or
/*
variable "user_names" {
  description = "IAM usernames"
  type        = set(string)
  default     = ["user1", "user2", "user3s"]
}*/

//or

variable "iam_users" {
  description = "map"
  type        = map(string)
  default     = {
    user1 = "normal_user"
    user2 = "admin_user"
    user3 = "root_user"
  }
}