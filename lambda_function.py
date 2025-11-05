import os

def lambda_handler(event, context):
    path = event.get("rawPath", "/")
    version = os.getenv("VERSION", "unknown")

    if path == "/health":
        return {"statusCode": 200, "body": '{"status":"ok"}'}
    elif path == "/version":
        return {"statusCode": 200, "body": f'{{"version":"{version}"}}'}
    else:
        return {"statusCode": 404, "body": '{"error":"not found"}'}
