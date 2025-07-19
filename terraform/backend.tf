terraform {
  backend "s3" {
    bucket         = "patient-appointment-app-tfstate-bucket"  # Must exist
    key            = "terraform.tfstate"
    region         = "us-west-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"  # Optional but recommended
  }
}
