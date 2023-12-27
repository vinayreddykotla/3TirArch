variable "ami" {
  default = "ami-0fc5d935ebf8bc3bc"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "key_name" {
  default = "nv_sshkeys"
}

variable "subnet_id" {
  default = "subnet-0790ca62eccb87948"
}

variable "vpc_security_group_ids" {
  default = "sg-0b619531d4da9d56a"
}

variable "iam_instance_profile" {
  default = "ec2SSMConnect1"
}
variable "cidr_block" {
  default = "10.0.0.0/16"
}
variable "instance_tenancy" {
  default = "default"
}
variable "enable_dns_support" {
  default = true
}
variable "enable_dns_hostnames" {
  default = true
}
