resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "${var.env}-devops-bucket"

  tags = {
    Name = "${var.env}-devops-bucket"
    Environment = var.env
  }
}