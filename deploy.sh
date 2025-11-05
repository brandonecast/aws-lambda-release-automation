#!/bin/bash
set -e

FUNCTION_NAME="release-basics-function"
ZIP_FILE="lambda_function.zip"
VERSION=$(cat version.txt)

echo "[*] Packaging Lambda function..."
zip -r $ZIP_FILE lambda_function.py > /dev/null

if ! aws lambda get-function --function-name $FUNCTION_NAME >/dev/null 2>&1; then
  echo "[*] Creating new Lambda function..."
  aws lambda create-function --function-name $FUNCTION_NAME     --runtime python3.11     --role $ROLE_ARN     --handler lambda_function.lambda_handler     --zip-file fileb://$ZIP_FILE     --environment Variables="{VERSION=$VERSION}" >/dev/null
else
  echo "[*] Updating existing Lambda function..."
  aws lambda update-function-code --function-name $FUNCTION_NAME     --zip-file fileb://$ZIP_FILE >/dev/null
  echo "[*] Waiting 30 seconds for Lambda to finish updating..."
  sleep 30
  aws lambda update-function-configuration --function-name $FUNCTION_NAME     --environment Variables="{VERSION=$VERSION}" >/dev/null
fi

echo "[*] Waiting for Lambda to become fully active before publishing version..."
aws lambda wait function-active --function-name $FUNCTION_NAME

PUBLISHED_VERSION=$(aws lambda publish-version --function-name $FUNCTION_NAME   --description "Release $VERSION" --query Version --output text)
echo "[*] Published version $PUBLISHED_VERSION"

if ! aws lambda get-alias --function-name $FUNCTION_NAME --name prod >/dev/null 2>&1; then
  aws lambda create-alias --function-name $FUNCTION_NAME --name prod     --function-version $PUBLISHED_VERSION >/dev/null
else
  aws lambda update-alias --function-name $FUNCTION_NAME --name prod     --function-version $PUBLISHED_VERSION >/dev/null
fi

echo "[*] Updated alias 'prod' -> version $PUBLISHED_VERSION"

URL=$(aws lambda list-function-url-configs --function-name $FUNCTION_NAME   --query 'FunctionUrlConfigs[0].FunctionUrl' --output text)
if [ "$URL" = "None" ]; then
  URL=$(aws lambda create-function-url-config --function-name $FUNCTION_NAME     --qualifier prod --auth-type NONE --query FunctionUrl --output text)
fi

echo "[✓] Deploy complete."
echo "    PROD URL: $URL"
