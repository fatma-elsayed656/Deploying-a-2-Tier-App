
variable "ami" {
    description= "to define the ami of ec2 instance"
    type= string 
}

variable "instance_type" {
    description= "to define the instance_type of ec2 instance"
    type= string 
}

variable "main_vpc_cidr" {
    description= "to define the main vpc cidr"
    type= string
}

variable "public_subnets" {
    description= "to define the cidr for the public subnet"
    type= string
}

variable "private_subnets" {
    description= "to define the cidr for the private subnet"
    type= string
}