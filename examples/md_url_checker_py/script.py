# Dependencies:
# packages: python3-lxml
# pip: markdown, lxml, requests

### 1 ###

## VIASH START

par = {
  "inputfile": "Testfile.md",
  "domain": "https://viash.io",
  "output": "output.txt"
}

## VIASH END

import markdown
from lxml import etree
import requests

### 2 ###

# Open markdown file, convert it to html and parse it to an ElementTree
with open(par["inputfile"], encoding="utf8") as file:
    md = file.read().replace('\n', '')

doc = etree.fromstring(markdown.markdown(md))

# Create and clear output file
output_file = open(par['output'], 'a')
output_file.truncate(0)

amount_of_urls = len(doc.xpath('//a'))
amount_of_errors = 0
expected_code = 200

### 3 ###

# Iterate over all hyperlinks and check each URL
for index, link in enumerate(doc.xpath('//a')):
    title = link.text
    url = link.get('href')

    ### 4 ###

    # If an URL doesn't start with 'http', add the domain before it
    if not url.startswith('http') and par["domain"] != None:
        url = '{}{}'.format(par["domain"] , url)

    print(str(index+1) + ": " + url)

    output_file.write("Link name: " + title + "\n")
    output_file.write("URL: " + url + "\n")

    ### 5 ###

    try:
        # Do a HEAD request and get the status code from the last response after following any redirects
        req = requests.head(url, allow_redirects=True)

        # Check if status code contains 200, which means the connection was succesful
        if req.status_code == 200:
            print('OK')
            output_file.write("Status: OK, can be reached.\n")
        else:
            print(req.status_code) 
            output_file.write("Status: ERROR! URL cannot be reached. Status code: " + str(req.status_code) + "\n")
            amount_of_errors+=1

    except requests.ConnectionError:
        print("Could not connect")
        output_file.write("Status: ERROR! URL cannot be reached. A connection error occured.\n")
        amount_of_errors+=1
    except:
        print("Something went wrong")
        output_file.write("Status: ERROR! URL cannot be reached. Something went wrong.\n")
        amount_of_errors+=1

    output_file.write("---\n")

print("\n" + par["inputfile"] + " has been checked and a report named " + par["output"] + " has been generated.\n" +
str(amount_of_errors) + " of " + str(amount_of_urls) + " URLs could not be resolved.")
