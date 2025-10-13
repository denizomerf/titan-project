resource "aws_security_group" "eks_nodes" {
  name        = "titan-eks-node-sg"
  description = "Security group for Titan EKS worker nodes"
  vpc_id      = aws_vpc.main.id

  # Kural 1: Dışarıya tüm trafiğe izin ver (İnternete çıkabilmeleri için).
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "titan-eks-node-sg"
  }
}



resource "aws_eks_cluster" "main" {
  name     = "titan-eks-cluster"
  role_arn = aws_iam_role.eks_cluster.arn
  version  = "1.29"

  vpc_config {
    # Use security_group_ids to associate security groups with the cluster
    security_group_ids = [aws_security_group.eks_nodes.id]
    subnet_ids         = [aws_subnet.private_a.id, aws_subnet.private_b.id]
  }




  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "titan-main-workers"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = [aws_subnet.private_a.id, aws_subnet.private_b.id]


  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.small"]
  disk_size      = 20

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_container_registry_read_only
  ]

}

resource "aws_security_group_rule" "nodes_ingress_from_lb" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks_nodes.id
  source_security_group_id = aws_security_group.eks_nodes.id
}
