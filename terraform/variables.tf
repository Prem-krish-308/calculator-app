variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
}

variable "environment" {
  description = "Dev environment"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "cluster_name" {
  description = "Name of the cluster is Calc-cluster"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "kubernetes_version" {
  description = "Kubernetes version for EKS"
  type        = string
}
