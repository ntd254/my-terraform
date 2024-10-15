variable "instance_type" {
  description = "The type of instance to launch"
}

variable "ami_id" {
  description = "The AMI ID to use for the instance"
}

variable "name" {
  description = "The name of the EC2 instance"
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the EC2 instance in"
  type        = string
}
