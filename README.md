# AWS Lambda Release Basics (v2)

This project demonstrates release automation for AWS Lambda — including deployment, versioning, aliasing, and verification. It simulates real-world release engineering workflows with AWS CLI and Linux shell scripting.

## Files
- **lambda_function.py** — Lambda backend exposing `/health` and `/version` endpoints.
- **version.txt** — Current release version.
- **deploy.sh** — Automated deployment script with waits and alias handling.
- **verify_release.sh** — Tests Lambda health and version after deployment.
- **README.md** — Documentation for GitHub showcase.

## Usage
1. Upload ZIP to AWS CloudShell.
2. Unzip and enter folder:
   ```bash
   unzip aws-lambda-release-basics-v2.zip
   cd aws-lambda-release-basics
   ```
3. Configure environment:
   ```bash
   export AWS_DEFAULT_REGION=us-east-1
   export ROLE_ARN=arn:aws:iam::<your-account-id>:role/lambda-basic-role
   ```
4. Deploy:
   ```bash
   echo "1.0.0" > version.txt
   bash deploy.sh
   ```
5. Verify:
   ```bash
   bash verify_release.sh <function-url> 1.0.0
   ```
