resource "aws_vpc" "this" {
  cidr_block            = "10.0.0.0/16"
  enable_dns_support    = true
  enable_dns_hostnames  = true
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}


// start of public subnet
data "aws_availability_zones" "available" {

}

resource "aws_subnet" "public_sn_az1" {
  vpc_id = aws_vpc.this.id
  cidr_block = "10.0.0.0/26" 
  map_public_ip_on_launch = true
#   availability_zone = "eu-west-1a"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "public-sn-az1"
  }
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.this.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.this.id
    }
        tags = {
    Name = "Public Route Table for AZ1"
  }
}

resource "aws_route_table_association" "public_rta_az1" {
  subnet_id = aws_subnet.public_sn_az1.id
  route_table_id = aws_route_table.public_rt.id
  
}
