module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "octopus"
  cluster_version = "1.22"

  cluster_endpoint_public_access = true

  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.public_subnets
  vpc_id                   = module.vpc.vpc_id

  eks_managed_node_group_defaults = {
    instance_types = ["t3.medium"]
    min_size       = 2
    max_size       = 3
    desired_size   = 2
  }

  eks_managed_node_groups = {
    octopus_nodes = {}
  }

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}