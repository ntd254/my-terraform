resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  managed_policy_arns = ["arn:aws:iam::aws:policy/IAMReadOnlyAccess"]
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAfIxsI3IIEnoKR4kNBqqK/xHtlMWGIF6AJPZPniQWIRxI+uQEqwUuTldUcuvTlhjRA1UVS59M9dRs30CJznUYtgWY/e5pv276QxlpeE/8D+Zu6yuiyiJC+BKZszUODIDXyrhTnb7Az7dDgq2M0CDYgT7Wfn5yk7NgoeGuIZLvVupheRQIpmCv4FaCDvB1Bo1TZv4lemyhxPiUXWJwbsiqj1SrF3/RHCIu8V6jh41r5YZeeErbnEfxUG7xi+QlisNkRT+eu5bTrdxSTs72VI5IFLVdv1i662XBdSOFcj29H6EO3Kb0Xnw9apa48fuqNSi2msrIRSDzSurwcib/OhkhY4zVEYSvOi+SMhg4dTSL6ecAJhRpyhBtItXcVLKLBQUFHk+tcZnlM0uxxKgz6xCckDuNtFhKTL9pwF8G4gBLDB3D7NtsNEXQefWY+PpPhYEH7OoldloxNUUwURkVog6n1yhZurIxqiWHCre9jpd9ARa6sn+rDOaAq5ciZn/a69M= ntdat254@ntdat254"
}

resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  key_name                    = aws_key_pair.deployer.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.security_group_id]
  subnet_id                   = var.subnet_id

  tags = {
    Name = var.name
  }

  # user_data = <<-EOT
  #             #!/bin/bash
  #             apt update -y
  #             apt install -y nginx
  #             EOT
}
