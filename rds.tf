resource "aws_db_subnet_group" "titan_db" {
  name       = "titan-db-subnet-group"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id]

  tags = {
    Name = "Titan DB Subnet Group"
  }
}

resource "aws_db_instance" "titan_db" {
  identifier           = "titan-db-instance"
  allocated_storage    = 20
  instance_class       = "db.t3.micro"
  engine               = "postgres"
  engine_version       = "17.6"
  username             = "titanadmin"
  password             = "BuSifreCokGuvensiz123"
  db_subnet_group_name = aws_db_subnet_group.titan_db.name
  vpc_security_group_ids = []

  multi_az              = true
  publicly_accessible   = false
  skip_final_snapshot   = true
  
  auto_minor_version_upgrade = true       # Küçük güncellemeleri otomatik al.
  monitoring_interval        = 60         # Detaylı sağlık raporunu 60 saniyede bir al.
  monitoring_role_arn        = aws_iam_role.rds_monitoring.arn # Raporları alacak özel izni ver.
  performance_insights_enabled = true     # Performans analizini aç.
  storage_encrypted          = true       # Diski şifrele.
  deletion_protection        = false      # ÖĞRENME PROJESİ İÇİN 'false', normalde 'true' olmalı.
  copy_tags_to_snapshot      = true       # Yedeklere de etiketleri kopyala.
  iam_database_authentication_enabled = true # IAM ile de bağlanabilmeyi aç.
  
  # Veritabanı loglarını CloudWatch'a gönder.
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  tags = {
    Name = "titan-db"
  }

  depends_on = [aws_iam_role_policy_attachment.rds_monitoring_attachment]
}

