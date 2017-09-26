resource "aws_route53_record" "grecoec2" {
  zone_id = "${var.route53zone}"
  name    = "${var.route53name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.greco_ec2.public_ip}"]
}