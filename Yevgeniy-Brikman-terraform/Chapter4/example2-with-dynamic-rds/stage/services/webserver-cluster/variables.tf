variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket used for the database's remote state storage"
  type        = string
}

variable "db_remote_state_key" {
  description = "The name of the key in the S3 bucket used for the database's remote state storage"
  type        = string
}

variable "cluster_name" {
  description = "The name to use to namespace all the resources in the cluster"
  type        = string
}

variable "env" {
  description = "The env vairbale like Prod or State"
  type        = string
}

variable "vpc-name" {
  description = "vpc name"
  type        = string
}
