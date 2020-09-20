region                = "us-west-2"
name                  = "vpc-dev"
# Primary CIDR block covers IP addresses: 10.0.0.0 thru 10.0.255.255
cidr                  = "10.0.0.0/16"
# Secondary CIDR blocks cover:
# 10.1.0.0 thru 10.1.0.255
# 10.2.0.0 thru 10.2.0.255
secondary_cidr_blocks = ["10.1.0.0/24", "10.2.0.0/24"]
