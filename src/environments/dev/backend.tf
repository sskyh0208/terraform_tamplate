terraform {
  backend "s3" {
    bucket = "<S3 Bucket Name>"
    key    = "terraform/dev.tfstate"
    region = "ap-northeast-1"
  }
}
