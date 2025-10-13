provider "kubernetes" {
  host                   = aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority.0.data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.main.name]
    command     = "aws"
  }
}

resource "kubernetes_config_map_v1_data" "aws_auth" {
  force = true

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    "mapRoles" = yamlencode(concat(
      [
        {
          rolearn  = aws_iam_role.github_actions.arn
          username = "github-actions"
          groups   = ["system:masters"]
        }
      ],

      [for role in [aws_iam_role.eks_nodes.arn] : {
        rolearn  = role
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = ["system:bootstrappers", "system:nodes"]
      }]
    ))
  }

  depends_on = [aws_eks_node_group.main]
}
