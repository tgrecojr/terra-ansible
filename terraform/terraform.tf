terraform {
  backend "s3" {
    bucket = "tjgtfstate"
    key    = "grecoec2"
    region = "us-east-1"
    encrypt = "true"
    dynamodb_table = "tfstate"
  }
}