output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "cloudtrail_bucket" {
  value = aws_s3_bucket.cloudtrail.id
}

output "developer_users" {
  value = [for user in aws_iam_user.developers : user.name]
}

output "operations_users" {
  value = [for user in aws_iam_user.operations : user.name]
}

output "analyst_users" {
  value = [for user in aws_iam_user.analysts : user.name]
}

output "finance_user" {
  value = aws_iam_user.finance.name
}