resource "aws_s3_bucket" "documentos_estaticos" {
  bucket = "documentos-estaticos-obligatorio-isc"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "move-to-infrequent-access"
    enabled = true

    transition {
      days          = var.current_transition_days_to_standard
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = var.current_transition_days_to_glacier
      storage_class = "GLACIER"
    }

    noncurrent_version_transition {
      days          = var.noncurrent_transition_days_to_standard
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      days          = var.noncurrent_transition_days_to_glacier
      storage_class = "GLACIER"
    }

    expiration {
      days = var.current_expiration_days
    }

    noncurrent_version_expiration {
      days = var.noncurrent_expiration_days
    }
  }
  depends_on = [aws_db_instance.rds_obligatorio, aws_eks_node_group.node_group_obligatorio]
}
