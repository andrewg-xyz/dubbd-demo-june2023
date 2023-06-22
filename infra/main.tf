# s3 bucket for state
resource "aws_s3_bucket" "state-bucket" {
  bucket = "uds-live-state-bucket"
}

# dynamodb for state locking
resource "aws_dynamodb_table" "terraform-lock" {
  name           = "uds-live-state-dynamodb"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}