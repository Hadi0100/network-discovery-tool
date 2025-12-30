# port_scanner.py
# Author: Hadi Abdelaal
# Description: Simple TCP port scanner

import socket
import csv

COMMON_PORTS = [21, 22, 23, 25, 53, 80, 110, 443, 3389]

def scan_port(ip, port):
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.settimeout(0.5)
        result = s.connect_ex((ip, port))
        s.close()
        return result == 0
    except:
        return False

def main():
    with open("../alive_hosts.txt") as f:
        hosts = f.read().splitlines()

    with open("scan_results.csv", "w", newline="") as file:
        writer = csv.writer(file)
        writer.writerow(["IP Address", "Port", "Status"])

        for host in hosts:
            for port in COMMON_PORTS:
                if scan_port(host, port):
                    print(f"[+] {host}:{port} OPEN")
                    writer.writerow([host, port, "OPEN"])

    print("Scan complete. Results saved to scan_results.csv")

if __name__ == "__main__":
    main()
