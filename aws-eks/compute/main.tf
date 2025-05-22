
# === compute/main.tf ===

data "aws_ami" "amzlinux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_key_pair" "bastion_key" {
  key_name = var.key_name

  public_key = file(var.public_key_path)
}


resource "aws_instance" "ec2_public" {

  ami           = data.aws_ami.amzlinux2.image_id
  instance_type = var.instance_type

  key_name = aws_key_pair.bastion_key.key_name

  subnet_id              = var.pub_subnet
  vpc_security_group_ids = var.bastion_public_sg_ids

  tags = {
    Name = "public-bastion-host"
  }
}

resource "null_resource" "copy_ec2_keys" {
  depends_on = [aws_instance.ec2_public]

  connection {
    type        = "ssh"
    host        = aws_instance.ec2_public.public_ip
    private_key = file("${path.root}/mtckey")
    user        = "ec2-user"
  }

  provisioner "file" {
    source      = "${path.root}/mtckey"
    destination = "/tmp/mtckey"
  }

  provisioner "remote-exec" {
    inline = ["sudo chmod 400 /tmp/mtckey"]
  }

  provisioner "local-exec" {
    command = "echo VPC created on `date` VPC-ID:- ${var.vpc_id} >> creation-time-vpc-id.txt"
  }
}