
resource "aws_s3_bucket" "relops_appveyor_artifacts" {
    bucket = "relops-appveyor-artifacts"
    acl = "public-read"
}

resource "aws_s3_bucket" "relops_appveyor_buildcache" {
    bucket = "relops-appveyor-buildcache"
    acl = "public-read"
}

