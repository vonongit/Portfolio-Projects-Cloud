# IAM Users

# Developers
resource "aws_iam_user" "developers" {
  for_each = toset(["dev-1", "dev-2", "dev-3", "dev-4"])
  name     = each.key
}

resource "aws_iam_user_group_membership" "dev_membership" {
  for_each = aws_iam_user.developers
  user     = each.value.name
  groups   = [aws_iam_group.developers.name]
}

# Operations
resource "aws_iam_user" "operations" {
  for_each = toset(["ops-1", "ops-2"])
  name     = each.key
}

resource "aws_iam_user_group_membership" "ops_membership" {
  for_each = aws_iam_user.operations
  user     = each.value.name
  groups   = [aws_iam_group.operations.name]
}

# Finance
resource "aws_iam_user" "finance" {
  name = "finance-1"
}

resource "aws_iam_user_group_membership" "finance_membership" {
  user   = aws_iam_user.finance.name
  groups = [aws_iam_group.finance.name]
}

# Analysts
resource "aws_iam_user" "analysts" {
  for_each = toset(["analyst-1", "analyst-2", "analyst-3"])
  name     = each.key
}

resource "aws_iam_user_group_membership" "analyst_membership" {
  for_each = aws_iam_user.analysts
  user     = each.value.name
  groups   = [aws_iam_group.analysts.name]
}