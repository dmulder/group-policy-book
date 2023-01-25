#!/usr/bin/python3
import os
from bs4 import BeautifulSoup

sections = {}

for topdir, dirs, files in os.walk('./EPUB/text'):
    # Search for section headers
    for fshort in files:
        fname = os.path.join(topdir, fshort)
        with open(fname, 'r') as f:
            soup = BeautifulSoup(f.read(), 'lxml')
            xml_sections = soup.find_all('section')
            for section in xml_sections:
                sections[section.get('id')] = fshort
    # Patch the invalid references
    for fshort in files:
        fname = os.path.join(topdir, fshort)
        with open(fname, 'r') as f:
            raw = f.read()
            soup = BeautifulSoup(raw, 'lxml')
            xml_links = soup.find_all('a')
            for link in xml_links:
                href = link.get('href').lstrip('#')
                if href in sections.keys():
                    raw = raw.replace('href="#%s"' % href, 'href="%s#%s"' % (sections[href], href))
        print('Patching invalid references in %s' % fname)
        with open(fname, 'w') as w:
            w.write(raw)
with open('./EPUB/text/cover.xhtml', 'r') as f:
    soup = BeautifulSoup(f.read(), 'lxml')
    svg = soup.find('svg')
    del svg['preserveaspectratio']
    del svg['viewbox']
with open('./EPUB/text/cover.xhtml', 'wb') as w:
    print("Removing invalid svg tags 'preserveaspectratio' and 'viewbox' from cover.xhtml")
    w.write(soup.prettify("utf-8"))
