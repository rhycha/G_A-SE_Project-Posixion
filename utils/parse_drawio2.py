import xml.etree.ElementTree as ET
import argparse
import json
import html
import re


def parse_drawio_xml(file_path):
    tree = ET.parse(file_path)
    root = tree.getroot()
    
    # Dictionary to store folder connections
    connections = {}
    
    # Dictionary to map cell ids to folder names
    id_to_name = {}
    
    # Find all vertex cells (folders)
    for cell in root.findall('.//mxCell[@vertex="1"]'):
        cell_id = cell.get('id')
        cell_value = cell.get('value')
        
        # Clean the cell value
        if cell_value:
            cell_value = html.unescape(cell_value)
            cell_value = re.sub(r'<[^>]*>', '', cell_value)  # Remove HTML tags
            cell_value = cell_value.strip()
        
        id_to_name[cell_id] = cell_value
        connections[cell_value] = []

    # Find all edge cells (connections)
    for cell in root.findall('.//mxCell[@edge="1"]'):
        source_id = cell.get('source')
        target_id = cell.get('target')
        
        # Get folder names from ids
        source_name = id_to_name.get(source_id)
        target_name = id_to_name.get(target_id)
        
        if source_name and target_name:
            connections[source_name].append(target_name)
            connections[target_name].append(source_name)
    
    return connections

def main():
    parser = argparse.ArgumentParser(description="Parse draw.io XML file to extract folder connections.")
    parser.add_argument("file", help="Path to the draw.io XML file")
    parser.add_argument("-o", "--output", help="Output JSON file path", default="connections.json")
    
    args = parser.parse_args()
    
    file_path = args.file
    output_path = args.output

    connections = parse_drawio_xml(file_path)
    
    # Print connections to the terminal
    print(connections)
    
    # Save connections to a JSON file
    with open(output_path, 'w') as json_file:
        json.dump(connections, json_file, indent=4)
    print(f"Connections saved to {output_path}")

if __name__ == "__main__":
    main()
