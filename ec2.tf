

resource "aws_default_vpc" "anshu_vpc"{

}

resource "aws_security_group" "example_security_group" {
  name        = "Anshu SG"
  description = "This is the security group for EC2 instance"
  vpc_id      = aws_default_vpc.anshu_vpc.id  # Replace with your VPC ID

  // Define ingress rules (inbound traffic)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere
  }

  // Define egress rules (outbound traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }
}

resource "aws_instance" "anshu_instance" {

	ami = var.ami
	instance_type = var.instance_type
	security_groups =[aws_security_group.example_security_group.name]
	key_name = var.key_pair

	tags = {
		name = "terraform_instance"	
	  }

	ebs_block_device {
    		device_name = "/dev/sdf"  // Device name (e.g., /dev/sdf)
   		volume_size = var.volume_size  // Size of the volume in GB
    		volume_type = "gp2"  // Volume type
    		encrypted   = true  // Whether the volume should be encrypted
  		}
}
