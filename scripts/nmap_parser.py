import xml.etree.ElementTree as ET
import csv
import sys
import os

def parse_nmap_xml(xml_file, output_csv):
    try:
        tree = ET.parse(xml_file)
        root = tree.getroot()
    except Exception as e:
        print(f"[!] Error reading XML: {e}")
        sys.exit(1)

    print(f"[*] Parsing {xml_file} to {output_csv}...")
    
    with open(output_csv, mode='w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(['IP Address', 'Port', 'Protocol', 'State', 'Service', 'Version'])

        for host in root.findall('host'):
            ip = host.find('address').attrib.get('addr')
            ports = host.find('ports')
            if ports is not None:
                for port in ports.findall('port'):
                    port_id = port.attrib.get('portid')
                    protocol = port.attrib.get('protocol')
                    state = port.find('state').attrib.get('state')
                    service = port.find('service')
                    
                    svc_name = service.attrib.get('name') if service is not None else 'Unknown'
                    svc_product = service.attrib.get('product') if service is not None else ''
                    svc_version = service.attrib.get('version') if service is not None else ''
                    full_version = f"{svc_product} {svc_version}".strip()

                    if state == 'open':
                        writer.writerow([ip, port_id, protocol, state, svc_name, full_version])

    print("[+] Parsing complete.")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python3 2_nmap_parser.py <input.xml> <output.csv>")
        sys.exit(1)
    parse_nmap_xml(sys.argv[1], sys.argv[2])
