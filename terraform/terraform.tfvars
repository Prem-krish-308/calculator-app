aws_region           = "ap-southeast-2"
environment          = "dev"
vpc_cidr             = "10.0.0.0/16"
cluster_name         = "Calculator-eks"
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
public_subnet_cidrs  = ["10.0.1.0/24"]
kubernetes_version   = "1.36"