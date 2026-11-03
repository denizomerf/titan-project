resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name              = "/aws/vpc/titan-flow-logs"
  retention_in_days = 7
}

resource "aws_flow_log" "main" {
  vpc_id          = aws_vpc.main.id
  traffic_type    = "ALL"
  iam_role_arn    = aws_iam_role.vpc_flow_log_role.arn
  log_destination = aws_cloudwatch_log_group.vpc_flow_logs.arn
}
