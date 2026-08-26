variable "aws_region" {
  description = "AWS region where the infrastructure will be deployed"
  type        = string
  default     = "eu-north-1"
}
variable "ami_id" {
  description = "Ubuntu 24.04 LTS AMI ID for eu-north-1"
  type        = string
}