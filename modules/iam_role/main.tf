resource "aws_iam_role" "ec2service" {
  name               = var.name
  description        = var.description
  path               = "/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = merge({
    Name     = var.name,
    CreateAt = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  },
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "AmazonEC2RoleforSSM" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  role       = aws_iam_role.ec2service.name
}

resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ec2service.name
}

resource "aws_iam_role_policy_attachment" "AmazonSSMDirectoryServiceAccess" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMDirectoryServiceAccess"
  role       = aws_iam_role.ec2service.name
}
