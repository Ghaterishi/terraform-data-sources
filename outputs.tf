output "security_group_id" {
  value = module.sg.security_group_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}