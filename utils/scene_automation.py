import xml.etree.ElementTree as ET

# Load and parse the XML file
tree = ET.parse('utils/level3_3.xml')
root = tree.getroot()

# Extract positions and text values
elements = []
for cell in root.findall('.//mxCell'):
    geometry = cell.find('.//mxGeometry')
    if geometry is not None and 'x' in geometry.attrib and 'y' in geometry.attrib:
        x = float(geometry.attrib['x'])
        y = float(geometry.attrib['y'])
        value = cell.attrib.get('value', '').strip()
        elements.append((x, y, value))

# Sort positions for grid layout (if needed)
elements.sort(key=lambda elem: (elem[1], elem[0]))

# Print the elements in the format needed for Godot script
formatted_elements = ["Vector2({}, {}), \"{}\"".format(x, y, value) for x, y, value in elements]
print("[" + ",\n".join(formatted_elements) + "]")
