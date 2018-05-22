
output "appveyor_build_cloud_security_group" {
  value = "${aws_security_group.relops_appveyor_allow_all_sg.id}"
}

output "appveyor_build_cloud_subnet_id" {
  value = "${module.vpc.public_subnets}"
}


