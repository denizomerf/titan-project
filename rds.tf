resource "aws_db_subnet_group" "titan_db" {
  name       = "titan-db-subnet-group"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id]

  tags = {
    Name = "Titan DB Subnet Group"
  }

}


resource "aws_db_instance" "titan_db" {
  identifier             = "titan-db-instance"
  allocated_storage      = 20
  instance_class         = "db.t3.micro"
  engine                 = "postgres"
  engine_version         = "17.6"
  username               = "titanadmin"
  # Password is generated and stored in AWS Secrets Manager by RDS (never in code)
  manage_master_user_password = true
  db_subnet_group_name   = aws_db_subnet_group.titan_db.name
  vpc_security_group_ids = []

  multi_az            = true
  publicly_accessible = false
  skip_final_snapshot = true


  tags = {
    Name = "titan-db"
  }


}
