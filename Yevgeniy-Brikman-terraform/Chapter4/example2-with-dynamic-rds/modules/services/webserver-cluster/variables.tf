variable "cluster_name" {
  description = "The name to use for all the cluster resources"
  type        = string
}

variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for the database's remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in S3"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
}

variable "min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
  type        = number
}

variable "max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
  type        = number
}

variable "desired_capacity" {
  description = "The desired capacity number of EC2 Instances in the ASG"
  type        = number
}

variable "env" {
  description = "The env vairbale like Prod or State"
  type        = string
}

variable "region" {
  description = "The default region to deploy the cluster"
  type        = string
}

variable "vpc-name" {
  description = "vpc name"
  type        = string
}
