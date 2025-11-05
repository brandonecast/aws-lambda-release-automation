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
I designed it to mirror a **Release Engineer**’s responsibilities: deploy reliably, version and alias releases, verify health, monitor logs, and handle rollbacks—**with clear steps, automation, and attention to detail**.

> **Why this aligns with Veeva Systems (Associate Release Engineer):**  
> - Coordinate releases & versions ✅  
> - Automate repeatable steps (scripts) ✅  
> - Resolve blockers (auth, resource locks) ✅  
> - Verify & monitor (health checks + CloudWatch) ✅  
> - Communicate clearly about what/why/how ✅

---

## 🧰 Tech Stack
- **AWS Lambda** – Serverless compute for fast, immutable releases  
- **AWS IAM** – Role-based execution permissions  
- **AWS CloudWatch** – Post-release monitoring & troubleshooting  
- **Bash / Linux** – Automation + CLI discipline  
- **AWS CLI** – Idempotent, scriptable deployments  
- **GitHub** – Documentation & portfolio

---

## 📦 What’s in this repo
- `lambda_function.py` — simple app exposing **`/health`** and **`/version`**  
- `deploy.sh` — **idempotent deploy** with **waits** + **version publish** + **prod alias**  
- `verify_release.sh` — quick **post-release checks**  
- `version.txt` — the release **single source of truth**  
- `docs/AWS_Lambda_Release_Automation.pdf` — one-page case study  
- `docs/` — add screenshots here (see table below)

---

## 🧭 End-to-End Walkthrough (exact steps I ran)


