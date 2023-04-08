resource "aws_dynamodb_table" "basic-dynamodb-table"  {
    name     = "student"
    hash_key = "id"
    billing_mode = "PROVISIONED"
    read_capacity = 5
    write_capacity = 5

    attribute {
      name = "id"
      type = "S"
    }
    tags = {
        Name = "student"
    }
}