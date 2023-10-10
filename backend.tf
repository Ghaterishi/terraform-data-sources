terraform {
  backend "s3" {
    bucket = "terraform-data-sources"
    key    = "terraform_state/dev_env/statefile.tfstate"
    region = "us-east-2" # Replace with your preferred AWS region
  }
}
