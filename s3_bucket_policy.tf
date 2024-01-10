resource "aws_s3_bucket_policy" "default" {
  bucket     = aws_s3_bucket.private_bucket.id
  policy     = data.aws_iam_policy_document.private.json
  depends_on = [aws_s3_bucket_public_access_block.block_public_access]
}

resource "aws_s3_bucket_policy" "custom_policy" {
  bucket     = aws_s3_bucket.private_bucket.id
  policy     = var.custom_iam_s3_policy
  depends_on = [aws_s3_bucket_public_access_block.block_public_access]
}