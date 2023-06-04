####### Create VPC #######
resource "aws_vpc" "myvpc" {
    cidr_block = var.main_vpc_cidr
    instance_tenancy = "default"

  tags = {
    Name = "my_vpc"
  } 
}


####### Create Internet Gateway and attach it to VPC #######
resource "aws_internet_gateway" "my_igw" {
    vpc_id =  aws_vpc.myvpc.id

    tags = {
    Name = "main_IGW"
  }               
}


####### Create a Public Subnets #######
resource "aws_subnet" "publicsubnets" {
    vpc_id =  aws_vpc.myvpc.id
    cidr_block = var.public_subnets
    map_public_ip_on_launch = true

    tags = {
    Name = "Public_sub"
  }
}


###### Create a Private Subnet ######
resource "aws_subnet" "privatesubnets" {
   vpc_id =  aws_vpc.myvpc.id
   cidr_block = var.private_subnets
   map_public_ip_on_launch = false

   tags = {
    Name = "Private_sub"
  }
}

####### Route table for Public Subnet's #######
resource "aws_route_table" "PublicRT" {
    vpc_id =  aws_vpc.myvpc.id
         route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
     }

     tags = {
    Name = "Public_Route_Table"
    }
}


####### Route table for Private Subnet's #######
resource "aws_route_table" "PrivateRT" {
    vpc_id = aws_vpc.myvpc.id
   route {
   cidr_block = "0.0.0.0/0"
   nat_gateway_id = aws_nat_gateway.NATgw.id
   }
   tags = {
    Name = "Private_Route_Table"
  }
}


####### Alocate Elastic Ip for NAT GateWay #######
resource "aws_eip" "elasticip" {
   vpc   = true
 }


 ####### Creating the NAT Gateway #######
 resource "aws_nat_gateway" "NATgw" {
   allocation_id = aws_eip.elasticip.id
   subnet_id = aws_subnet.publicsubnets.id
 }