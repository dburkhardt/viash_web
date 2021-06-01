import unittest
from os import path
import subprocess

class Tester(unittest.TestCase):
    def test_arguments(self):
        out = subprocess.check_output(["./md_url_checker_py", "--inputfile", "Testfile.md", "--domain", "https://viash.io"]).decode("utf-8")
        self.assertIn("1: https://www.google.com", out) # Did the script find the URL?
        self.assertIn("404", out) # Did the web request return a 404 for the page that doesn't exist?
        
    def test_output_file(self):
        with open ("output.txt", "r") as output:
            out=output.readlines()
        self.assertIn("URL: https://www.google.com\n", out) # Was the URL written correctly in the report?
        self.assertIn("Status: ERROR! URL cannot be reached. Status code: 404\n", out) # Was the error written correctly in the report?
        self.assertIn("Link name: install viash here\n", out) # Was the error written correctly in the report?


unittest.main()
