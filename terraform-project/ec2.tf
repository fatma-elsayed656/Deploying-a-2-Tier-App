#Create EC2 instance in public subnet
resource "aws_instance" "Public_ec2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.publicsubnets.id

  
}

#Create EC2 instance in private subnet
resource "aws_instance" "Private_ec2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.privatesubnets.id

}
