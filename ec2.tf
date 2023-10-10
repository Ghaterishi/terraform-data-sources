data "terraform_remote_state" "vpc_configuration" {
  backend = "s3"
  config = {
    bucket = "terraform-data-sources"
    key    = "terraform_state/dev_env/statefile.tfstate"
    region = "us-east-2"
  }
}

module "ec2_instance" {
#   depends_on = [module.vpc]
  source     = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["one", "two", "three"])

  name = "instance-${each.key}"

  instance_type          = "t2.micro"
  key_name               = "demo_key"
  monitoring             = true
  vpc_security_group_ids = [data.terraform_remote_state.vpc_configuration.outputs.security_group_id]
  subnet_id              = data.terraform_remote_state.vpc_configuration.outputs.private_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}