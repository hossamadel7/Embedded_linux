#!/bin/bash

# Bash Script to Analyze Network Traffic

# Input: Path to the Wireshark pcap file
pcap_file=$1 # capture input from terminal.

# Function to extract information from the pcap file
analyze_traffic() {
    # Use tshark or similar commands for packet analysis.
    # Hint: Consider commands to count total packets, filter by protocols (HTTP, HTTPS/TLS),
    # extract IP addresses, and generate summary statistics.

    # Output analysis summary
    echo "----- Network Traffic Analysis Report -----"
    
    # Provide summary information based on your analysis
    # Hints: Total packets, protocols, top source, and destination IP addresses.
    your_total_packets=$(tshark -r "$pcap_file" -Y "http or tls" 2>/dev/null | wc -l)
    echo "1. Total Packets: $your_total_packets "

    your_http_packets=$( tshark -r "$pcap_file" -Y "http" 2>/dev/null | wc -l)
    your_https_packets=$( tshark -r "$pcap_file" -Y "tls" 2>/dev/null | wc -l)
    
    echo "2. Protocols:"
    echo "   - HTTP: $your_http_packets packets"
    echo "   - HTTPS/TLS: $your_https_packets packets"
    echo ""
    echo "3. Top 5 Source IP Addresses:"
    # Provide the top source IP addresses
    your_top_source_ips=$( tshark -r "$pcap_file" -Y "http or tls" -T fields -e ip.src | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2, $1}')
    echo "$your_top_source_ips"
    echo ""
    echo "4. Top 5 Destination IP Addresses:"
    # Provide the top destination IP addresses
    your_top_dest_ips=$( tshark -r "$pcap_file" -Y "http or tls" -T fields -e ip.dst | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2, $1}')
    echo "$your_top_dest_ips"
    echo ""
    echo "----- End of Report -----"
}

# Run the analysis function
analyze_traffic
