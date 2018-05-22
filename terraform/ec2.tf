
resource "aws_security_group" "relops_appveyor_allow_all_sg" {
  name        = "relops_appveyor_build_cloud_sg"
  description = "Allow all inbound traffic for appveyor build cloud workers"

  vpc_id = "${module.vpc.vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "relops_appveyor_build_cloud_sg"
    Owner       = "relops"
    Environment = "dev"
    Terraform   = "true"
  }
}

