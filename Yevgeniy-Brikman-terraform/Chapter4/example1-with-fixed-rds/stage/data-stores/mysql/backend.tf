terraform {
  backend "s3" {
    bucket         = "ne-terraform-state-backup"
    key            = "stage/data-stores/mysql/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "ne-terraform-state-backup-locking"
    encrypt        = true
  }
}