resource "aws_s3_bucket" "backend_bucket" {
    bucket = "trevors-cloud-resume-frontend-state-bucket"
    tags = {
        Name = "Frontend State Bucket"
        Environment = "Prod"
    }
}

resource "aws_s3_bucket_versioning" "versioning" {
    bucket = aws_s3_bucket.backend_bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}