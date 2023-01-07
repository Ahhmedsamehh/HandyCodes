import os
import sys
import re
import csv
import pandas as pd

PDB_directory = "C:\Ahmed Sameh\EgyCyte\TRY"
os.chdir(PDB_directory)

ext = ('.pdb')

csv_file = open("results.csv","w")
writer = csv.writer(csv_file)

writer.writerow(['Name inside PDB file', 'ID Code of the PDB', 'Its abbreviation (Residue name)', 'Chain ID', 'Sequence number', 'Standard resiude name', 'Description of the modification'])

for files in os.listdir(PDB_directory):
    if files.endswith(ext):
        print(files)
        a = open(files)
        for line in a:
            if 'MODRES' in line:
                MODRES_line = line
                MODRES_line_modified = MODRES_line.split()
                new = []
                new = MODRES_line_modified
                csv_file = open("results.csv", "a")
                writer = csv.writer(csv_file)
                writer.writerow(new)
                print(new)
                continue
            continue
        continue
    continue