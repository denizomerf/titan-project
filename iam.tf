
data "aws_iam_policy_document" "github_actions_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type = "Federated"
      identifiers = ["arn:aws:iam::308740035407:oidc-provider/token.actions.githubusercontent.com"] 
    }
    condition {
      test = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values = ["repo:denizsariyildiz/titan-project:ref:refs/heads/main"]
    }
  }
  
}


resource "aws_iam_role" "github_actions" {
  
    name = "titan-github-actions-role"
    assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role.json
}

resource "aws_iam_role_policy_attachment" "github_actions_ecr" {
    role       = aws_iam_role.github_actions.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  
}