
#resource "aws_key_pair" "auth" {
#  key_name   = "${var.key_name}"
#  public_key = "${file(var.public_key_path)}"
#}

resource "aws_instance" "greco_ec2" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The default username for our AMI
    user = "${var.vm_user}"

    # The connection will use the local SSH agent for authentication.
  }

  instance_type = "t2.micro"
  tags = "${var.tags}"

  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.aws_amis, var.region)}"

  # The name of our SSH keypair
  key_name = "${var.key_name}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.greco_security_group.id}"]

  subnet_id = "${aws_subnet.greco_subnet.id}"

  associate_public_ip_address = true

  root_block_device {
    volume_type = "standard"
    volume_size = "20"
    delete_on_termination = "true"
  }

  # force Terraform to wait until a connection can be made, so that Ansible doesn't fail when trying to provision
  provisioner "remote-exec" {
    inline = [
      "echo 'Remote execution connected.'"
    ]
  }
}

