
# Create an AWS ElastiCache Redis cluster
resource "aws_elasticache_subnet_group" "subnet_group" {
  name        = "redis-subnet-group"
  description = "Redis subnet group"

  subnet_ids = [aws_subnet.private[0].id, aws_subnet.private[1].id]
}

resource "aws_elasticache_parameter_group" "parameter_group" {
  name   = "redis-parameter-group"
  family = "redis5.0"

  parameter {
    name  = "notify-keyspace-events"
    value = "AKE"
  }
}

resource "aws_elasticache_cluster" "redis_cluster" {
  cluster_id               = "redis-cluster"
  engine                   = "redis"
  engine_version           = "5.0.6"
  node_type                = "cache.t2.micro"
  num_cache_nodes          = 1
  parameter_group_name     = aws_elasticache_parameter_group.parameter_group.name
  subnet_group_name        = aws_elasticache_subnet_group.subnet_group.name
  security_group_ids       = [aws_security_group.cache.id]
  maintenance_window       = "wed:03:00-wed:04:00"
  snapshot_window          = "01:00-02:00"
  snapshot_retention_limit = 7


}
