provider "aws" {
  region = var.aws_region
}

resource "random_pet" "petname" {
  length    = 4
  separator = "-"
}

resource "aws_s3_bucket" "dev" {
  bucket = "hc-digital-${var.dev_prefix}-${random_pet.petname.id}"
  acl    = "public-read"

  force_destroy = true

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::hc-digital-${var.dev_prefix}-${random_pet.petname.id}/*"
            ]
        }
    ]
}
EOF

  tags = {
    Project = "HashiConf-Digital"
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_object" "dev" {
  acl          = "public-read"
  key          = "index.html"
  bucket       = aws_s3_bucket.dev.id
  content      = file("${path.module}/assets/index.html")
  content_type = "text/html"
}

resource "aws_s3_bucket" "prod" {
  bucket = "hc-digital-${var.prod_prefix}-${random_pet.petname.id}"
  acl    = "public-read"

  force_destroy = true

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::hc-digital-${var.prod_prefix}-${random_pet.petname.id}/*"
            ]
        }
    ]
}
EOF

  tags = {
    Project = "HashiConf-Digital"
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_object" "prod" {
  acl          = "public-read"
  key          = "index.html"
  bucket       = aws_s3_bucket.prod.id
  content      = file("${path.module}/assets/index.html")
  content_type = "text/html"
}
