output "public_ip" {
  description = "The public IP address of the created EC2 instance"
  value       = aws_instance.anshu_instance.public_ip
}
