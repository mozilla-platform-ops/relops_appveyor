
resource "aws_iam_user" "relops_appveyor" {
  name = "relops_appveyor"
  path = "/"
}

data "aws_iam_policy_document" "allow_s3_rw_relops_appveyor_buckets" {
  statement {
    actions = [
      "s3:*",
    ]
    resources = [
      "${aws_s3_bucket.relops_appveyor_artifacts.arn}/*",
      "${aws_s3_bucket.relops_appveyor_buildcache.arn}/*",
    ]
  }
}

data "template_file" "ec2_access_policy" {
  template = "${file("${path.module}/templates/limit_ec2_to_vpc.tpl")}"

  vars {
    ACCOUNTNUMBER = "${data.aws_caller_identity.current.account_id}"
    REGION = "${var.region}"
    VPC-ID = "${module.vpc.vpc_id}" 
  }
}


resource "aws_iam_user_policy" "relops_appveyor_s3_policy" {
  name = "RelopsAppveyorS3AccessBucket"
  user = "${aws_iam_user.relops_appveyor.name}"
  policy = "${data.aws_iam_policy_document.allow_s3_rw_relops_appveyor_buckets.json}"
}

resource "aws_iam_policy" "limit_ec2_to_vpc" {
  name = "RelopsLimitEC2toRelopsVPC"
  policy = "${data.template_file.ec2_access_policy.rendered}"
}

resource "aws_iam_user_policy_attachment" "appveyor_ec2_access" {
    user       = "${aws_iam_user.relops_appveyor.name}"
    policy_arn = "${aws_iam_policy.limit_ec2_to_vpc.arn}"
}


#resource "aws_iam_user_policy_attachment" "full_ec2_access" {
#    user       = "${aws_iam_user.relops_appveyor.name}"
#    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
#}
