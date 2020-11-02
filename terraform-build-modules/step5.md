You will need to delete the files in your bucket before the bucket can be 
destroyed.

`aws s3 rm s3://$(terraform output website_bucket_name)/ --recursive`{{execute}}

Once the bucket is empty, destroy your Terraform resources.

`terraform destroy`{{execute}}

After you respond to the prompt with `yes`{{execute}}, Terraform will destroy 
the infrastructure you created.

