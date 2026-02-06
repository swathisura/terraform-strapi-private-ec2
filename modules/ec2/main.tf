resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y docker.io
              systemctl start docker
              systemctl enable docker

              docker run -d \
                -p 1337:1337 \
                --name strapi \
                strapi/strapi
              EOF

  tags = {
    Name = "strapi-ec2"
  }
}
