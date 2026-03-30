#!/bin/bash
# Description: Automated Reconnaissance Wrapper

if [ -z "$1" ]; then
    echo "[!] Usage: ./1_recon.sh <TARGET-IP>"
    exit 1
fi

TARGET=$1
OUTDIR="../reports/scans"
mkdir -p $OUTDIR

echo "[+] Starting Nmap Fast Scan on $TARGET..."
nmap -F -T4 $TARGET -oN $OUTDIR/nmap_fast.txt

echo "[+] Starting Comprehensive Nmap Scan (saving as XML)..."
nmap -sV -sC -p- -T4 $TARGET -oX $OUTDIR/nmap_full.xml

echo "[+] Checking for open web ports (80, 4443, 8080)..."
if grep -q "80/tcp open" $OUTDIR/nmap_fast.txt || grep -q "8080/tcp open" $OUTDIR/nmap_fast.txt; then
    echo "[+] Web service detected. Launching Gobuster..."
    # Assuming port 8080 based on docker-compose setup
    gobuster dir -u http://$TARGET:8080 -w /usr/share/wordlists/dirb/common.txt -q -o $OUTDIR/gobuster_dirs.txt
fi

echo "[*] Reconnaissance complete. Results saved to $OUTDIR"
