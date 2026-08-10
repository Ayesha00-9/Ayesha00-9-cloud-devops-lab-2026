terraform {
  backend "s3" {
    bucket         = "cloud-devops-tf-state-ayesha"
    key            = "terraform/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "cloud-devops-tf-lock"
    encrypt        = true
  }
}