terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = "us-west-2"
}

resource "aws_s3_bucket" "bucket1" {
    bucket = "codecarnival-mckd-bucket"

    tags = {
      Name = "Code Carnival Bucket"
    }
  

}
resource "aws_s3_bucket_ownership_controls" "bucket1" {

    bucket = aws_s3_bucket.bucket1.id
    rule {
      object_ownership = "BucketOwnerPreferred"
    }
}
resource "aws_s3_bucket_acl" "bucket1" {
  depends_on = [ aws_s3_bucket_ownership_controls.bucket1 ]

  bucket = aws_s3_bucket.bucket1.id
  acl = "private"
}

resource "aws_s3_bucket" "bucket2" {
    bucket = "datasummit-mckd-bucket"

    tags = {
      Name = "Data Summit Bucket"
    }
  
}
resource "aws_s3_bucket_ownership_controls" "bucket2" {
    bucket = aws_s3_bucket.bucket2.id
    rule {
      object_ownership = "BucketOwnerPreferred"
    }

}
resource "aws_s3_bucket_acl" "bucket2" {
    depends_on = [ aws_s3_bucket_ownership_controls.bucket2 ]

    bucket = aws_s3_bucket.bucket2.id
    acl = "private"
  
}

resource "aws_s3_bucket" "bucket3" {
    bucket = "adventuretech-mckd-bucket"
    
    tags = {
        Name = "Adventure Tech Bucket"
    }
}
resource "aws_s3_bucket_ownership_controls" "bucket3" {
    bucket = aws_s3_bucket.bucket3.id
    rule {
      object_ownership = "BucketOwnerPreferred"
    }

}
resource "aws_s3_bucket_acl" "bucket3" {
    depends_on = [ aws_s3_bucket_ownership_controls.bucket3 ]

    bucket = aws_s3_bucket.bucket3.id
    acl = "private"
  
}
output "buckets_created" {
  value = {
    "bucket1" = aws_s3_bucket.bucket1.bucket,
    "bucket2" = aws_s3_bucket.bucket2.bucket,
    "bucket3" = aws_s3_bucket.bucket3.bucket
  }
  description = "The names of the created S3 buckets"
}
