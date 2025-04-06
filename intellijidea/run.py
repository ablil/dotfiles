#!/usr/bin/env python3

import os
import dataclasses
import xml.etree.ElementTree as ET
import re


@dataclasses.dataclass
class Template:
    shortcut: str
    snippet: str
    target: str
    description: str
    variables: list[ str ]

def parse_variables(content: str) -> list[ str ]:
    return re.findall(r'\$\w+\$', content)

def read_template_file(file: str):
    assert os.path.exists(file),  f"{file} NOT found"

    with open(file) as r:
        head, snippet = r.read().split("---")
        headers = head.splitlines()

        return Template(
            shortcut = next(filter(lambda header: header.startswith('shortcut'), headers)).split(':')[-1].strip(),
            target = next(filter(lambda header: header.strip().startswith('target'), headers)).split(':')[-1].strip(),
            description = next(filter(lambda header: header.startswith('description'), headers)).split(':')[-1].strip(),
            snippet = snippet.strip(),
            variables = set([var.strip('$') for var in parse_variables(snippet)])
        )

def sanitize(content: str) -> str:
    #return content.replace('\n', '&#10;')
    return content

def convert_template_to_xml(template: Template) -> ET:
    root = ET.Element('template')
    root.attrib['name'] = template.shortcut
    root.attrib['value'] = sanitize(template.snippet)
    root.attrib['description'] = template.description
    root.attrib['toShortenFQNames'] = 'true'
    root.attrib['toReformat'] = 'true'
    root.attrib['useStaticImport'] = 'true'

    context = ET.SubElement(root, 'context')
    option = ET.SubElement(context, 'option')
    option.attrib['name'] = template.target.upper()
    option.attrib['value'] = 'true'

    for var in template.variables:
        variable = ET.SubElement(root, 'variable')
        variable.attrib['name'] = var
        variable.attrib['expression'] = f'escapeString("{var}")'
        variable.attrib['defaultValue'] = ''
        variable.attrib['alwaysStopAt'] = 'true'

    return root

def read_template_set(directory: str):
    assert os.path.exists(directory), f"{directory} NOT found"
    
    filenames = [os.path.join(directory, f) for f in os.listdir(directory) if os.path.isfile(os.path.join(directory, f))]
    templates = [read_template_file(filename) for filename in filenames]
    xml_elements = [convert_template_to_xml(template) for template in templates]

    root = ET.Element('templateSet')
    root.attrib['group'] = "custom-" + directory.split('/')[-1]
    root.extend(xml_elements)

    ET.indent(root)
    return ET.tostring(root).decode()

def main():
    for directory in filter(lambda directory: os.path.isdir(os.path.join('templates', directory)), os.listdir('templates')):
        with open(f"custom-{directory}.xml", 'w') as f:
            f.write(read_template_set(os.path.join('templates', directory)))

main()
