
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-2a", "us-east-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "sg" {
    source = "./SG"
    security_group_name="ec2_sg"
    vpc_id = module.vpc.vpc_id

    ingress_rules= [
    {
        from_port= 22           #Specific ingrss port for this rule
        to_port=22
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]  #Specific CIDR block for this rule
    },
    {
        from_port= 80           #Specific ingrss port for this rule
        to_port=80
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]  #Specific CIDR block for this rule
    }
    ]

    egress_rules = [
    { 
      from_port   = 0                    #Specific egress port for this rule
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]  #Specific CIDR block for this rule
    }
    ] 

}