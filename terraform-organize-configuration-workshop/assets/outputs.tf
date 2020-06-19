output "dev_website_endpoint" {
  description = "Website endpoint for the dev environment"
  value       = "http://${aws_s3_bucket.dev.website_endpoint}/index.html"
}

output "prod_website_endpoint" {
  description = "Website endpoint for the prod environment"
  value       = "http://${aws_s3_bucket.prod.website_endpoint}/index.html"
}
