# AWS Lambda Release Automation 🚀  
![AWS](https://img.shields.io/badge/AWS-Cloud-orange?logo=amazonaws)
![Bash](https://img.shields.io/badge/Shell-Bash-green?logo=gnu-bash)
![Linux](https://img.shields.io/badge/OS-Linux-blue?logo=linux)
![CI/CD](https://img.shields.io/badge/CI%2FCD-Automation-lightgrey?logo=githubactions)

### By **Brandon Castaneda**  
📧 brandonc0914@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/brandon-c-5b4877369)

---

## 🧠 Overview
This project demonstrates an **end-to-end release automation workflow** on AWS using **Lambda, IAM, CloudWatch** and **Linux/Bash scripting**.  
It mirrors the **Release Engineer** mindset: deploying reliably, managing versions and aliases, validating endpoints, monitoring logs, and rolling back when necessary — all with a focus on automation and observability.

> **Why this aligns with Veeva Systems (Associate Release Engineer):**  
> - Coordinates releases & versions ✅  
> - Automates repeatable steps (scripts) ✅  
> - Troubleshoots blockers (auth, resource locks) ✅  
> - Verifies & monitors (health checks + CloudWatch) ✅  
> - Documents and communicates clearly ✅

---

## 🧰 Tech Stack
- **AWS Lambda** – Serverless compute for fast, immutable releases  
- **AWS IAM** – Role-based execution permissions  
- **AWS CloudWatch** – Post-release monitoring & troubleshooting  
- **Bash / Linux** – Automation + CLI discipline  
- **AWS CLI** – Scriptable, idempotent deployments  
- **GitHub** – Documentation & version control

---

## 🧭 End-to-End Walkthrough

### 0️⃣ Setup (CloudShell + IAM)
```bash
aws configure
export AWS_DEFAULT_REGION=us-east-1
export ROLE_ARN=arn:aws:iam::<your-account-id>:role/lambda-basic-role
```
🔹 **Why:** Connects your CloudShell (the release terminal) to your AWS account securely with proper IAM permissions.

---

### 1️⃣ Upload & Unpack
Upload `aws-lambda-release-basics-v2.zip` to AWS CloudShell, then:
```bash
unzip aws-lambda-release-basics-v2.zip
cd aws-lambda-release-basics
ls
```
✅ Expected files:
```
lambda_function.py  deploy.sh  verify_release.sh  version.txt  README.md
```

---

### 2️⃣ First Release – v1.0.0 🚀
```bash
echo "1.0.0" > version.txt
bash deploy.sh
```
🖥️ **Sample Output:**
```
[*] Packaging Lambda function...
[*] Creating new Lambda function...
[*] Waiting 30 seconds for Lambda to finish updating...
[*] Waiting for Lambda to become fully active before publishing version...
[*] Published version 1
[*] Updated alias 'prod' -> version 1
[✓] Deploy complete.
    PROD URL: https://<your-lambda-url>/
```
🔹 **Why:** Automates packaging, deployment, versioning, and alias updates.

---

### 3️⃣ Verify Health & Version
```bash
curl [your-lambda-url-here]/health
curl [your-lambda-url-here]/version
```
✅ Expected:
```json
{"status":"ok"}
{"version":"1.0.0"}
```
🔹 **Why:** Confirms the release deployed correctly — the equivalent of a smoke test in production.

---

### 4️⃣ Troubleshooting & Fixes 🔧

#### 🛠️ Lambda Update Conflict (`ResourceConflictException`)
**Cause:** Function locked during concurrent updates.  
**Fix:** Added `sleep` and `aws lambda wait function-active` inside `deploy.sh` to pause until AWS finishes internal updates.

#### 🔒 “Forbidden” Errors on Function URL
**Cause:** Alias (`prod`) URLs need explicit invoke permissions.  
**Fix:**  
```bash
aws lambda add-permission   --function-name release-basics-function:prod   --action lambda:InvokeFunctionUrl   --principal "*"   --function-url-auth-type NONE   --statement-id allow-public-access
```
🧩 **Reflection:** This was a real release engineering challenge — identify the root cause, patch automation, and document the fix for the next iteration.

---

### 5️⃣ Second Release – v1.1.0 🔁
```bash
echo "1.1.0" > version.txt
bash deploy.sh
```
🖥️ **Output:**
```
[*] Updating existing Lambda function...
[*] Waiting 30 seconds for Lambda to finish updating...
[*] Waiting for Lambda to become fully active before publishing version...
[*] Published version 2
[*] Updated alias 'prod' -> version 2
[✓] Deploy complete.
```
✅ Verified with:
```bash
curl [your-lambda-url-here]/version
{"version":"1.1.0"}
```

---

### 6️⃣ View Version History 🗂️
```bash
aws lambda list-versions-by-function   --function-name release-basics-function   --query "Versions[*].{Version:Version,Description:Description}"
```
📄 Example:
```json
[
  {"Version":"$LATEST","Description":"Release 1.1.0"},
  {"Version":"1","Description":"Release 1.0.0"},
  {"Version":"2","Description":"Release 1.1.0"}
]
```

---

### 7️⃣ Rollback Simulation ⏪
If a bug occurs in `v1.1.0`, roll back safely:
```bash
aws lambda update-alias   --function-name release-basics-function   --name prod   --function-version 1
```
Verify:
```bash
curl [your-lambda-url-here]/version
{"version":"1.0.0"}
```
🔹 **Why:** Rollbacks ensure stability during high-impact releases.

---

### 8️⃣ Monitor with CloudWatch 📊
**Console:** Navigate to  
`CloudWatch → Log groups → /aws/lambda/release-basics-function`  
**CLI:**
```bash
aws logs filter-log-events   --log-group-name "/aws/lambda/release-basics-function"   --limit 5   --query "events[*].message"
```
🔹 **Why:** Post-release monitoring is critical to verify performance and detect anomalies quickly.

---

## 💡 Lessons Learned (Reflective)
- Patience and precision matter — AWS deployments need timing awareness.  
- Permissions can be subtle — alias-based URLs require explicit policies.  
- Automation ≠ fire-and-forget — monitoring and rollback make it robust.  
- Every release should be traceable, reversible, and observable.  

🧠 **Release Engineering takeaway:** Be proactive, not reactive. Anticipate failure modes, script guardrails, and document everything.

---

## 🧾 Outcome
✅ A **reliable, versioned, and monitored Lambda release pipeline** featuring:
- Automated deployments  
- Health and version verification  
- Rollback safety net  
- CloudWatch insights  
- Troubleshooting logs & learnings  

🎯 **Demonstrates:** Ownership, automation mindset, and cross-functional readiness — directly aligned with **Veeva’s mission to deliver reliable, high-quality software faster**.

---
