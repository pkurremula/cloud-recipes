# AWSCLI Cheat Sheet

## Install

Information is currently only for Mac.

1. Install gcloud via Homebrew.

   ```bash
   $ brew install awscli
   ```

## Common Tasks

| Operation | CLI Example | Notes |
|-----------|-------------|-------|
| Get regions | `aws ec2 describe-regions --output table` ||
| Get AZs of default region | `aws ec2 describe-availability-zones` | Uses the region in user profile. |
