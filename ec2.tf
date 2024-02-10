

resource "aws_instance" "ec2-client" {
  ami             = "ami-0323d48d3a525fd18" 
  instance_type   = "t2.micro"  
  subnet_id       = aws_subnet.public_sn_az1.id
  vpc_security_group_ids = [aws_security_group.ssh_sg.id, aws_security_group.http_ingress.id]
  key_name        = "default-eu1"  
iam_instance_profile = aws_iam_instance_profile.session_manager_profile.name
  user_data_replace_on_change = true
  user_data = "${file("userdata.sh")}"
  tags = {
    Name = "ec2-client"
  }
}



output "instance_private_ip" {
  value = aws_instance.ec2-client.private_ip
}
output "instance_public_ip" {
  value = aws_instance.ec2-client.public_ip
}
