# Full-Scope-Network-Penetration-Testing-Lab
## 📌 Project Overview
A comprehensive virtualized penetration testing environment simulating an enterprise network. This project demonstrates the end-to-end Vulnerability Management Life Cycle, from reconnaissance and exploitation to post-exploitation and remediation reporting, following the **PTES methodology**.

## 🏗️ Architecture & Tech Stack
* **Hypervisor:** VMware / Docker
* **Attacker:** Kali Linux
* **Targets:**
  * Windows Server (Legacy SMB vulnerabilities)
  * Vulnerable Web Application Container (DVWA)
  * Misconfigured Linux Host (Privilege Escalation)
* **Tools:** Nmap, Metasploit, Gobuster, Python, Bash

## 🚀 Quick Start
To spin up the web application target locally for testing:
\`\`\`bash
cd setup/
docker-compose up -d
\`\`\`

## ⚔️ Methodology
1. **Reconnaissance:** Automated network mapping and service enumeration using custom bash and python scripts.
2. **Exploitation:** Leveraged MS17-010 to gain `SYSTEM` access and exploited web vulnerabilities to gain initial `www-data` shells.
3. **Privilege Escalation:** Exploited SUID bit misconfigurations to escalate from standard user to `root`.
4. **Reporting:** Generated a professional executive summary and technical findings report.
