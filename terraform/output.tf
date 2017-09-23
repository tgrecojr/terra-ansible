output "address" {
  value = "${aws_instance.greco_ec2.public_ip}"
}

output "ssh" {
  value = "ssh ${var.vm_user}@${aws_instance.greco_ec2.public_ip}"
}