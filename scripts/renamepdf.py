#!python3.8

import subprocess as sp
import os
import sys

class COLORS:
    HEADER = '\033[95m'
    WHITE = '\033[97m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

# Check if pdftitle exists
try:
    sp.run(['pdftitlfe'], stderr=sp.PIPE)
except FileNotFoundError:
    print("\nFirst install pdftitle 'pip3 install pdftitle'")
    install_ans = input("\nDo you want to? [y/N]: ").lower()
    if install_ans == "y":
       sp.run(['pip3', 'install', 'pdftitle'])


def rename_that_shiz(pdf):
    
    proc = sp.run(['pdftitle', '-p', pdf], stdout=sp.PIPE)
    rename_output = proc.stdout.decode('utf-8').replace('\n', '').replace(':', " -") + ".pdf"

    if rename_output == '' or rename_output == ".pdf":
        print(f"\n{COLORS.WARNING}Cant Find the name for {COLORS.BOLD}{COLORS.UNDERLINE}{pdf}{COLORS.ENDC}{COLORS.WARNING}... Sorry{COLORS.ENDC}")
    elif rename_output == pdf:
        print(f"\n{COLORS.HEADER}You have the name for {COLORS.BOLD}{COLORS.UNDERLINE}{pdf}{COLORS.ENDC}{COLORS.HEADER} already!{COLORS.ENDC}")
    else:
        usr_input = input(f"\n{COLORS.UNDERLINE}Do you want to Rename:{COLORS.ENDC} \n{COLORS.OKBLUE}{pdf} -> {COLORS.OKGREEN}{rename_output}{COLORS.ENDC} {COLORS.BOLD}[y/N/r]: {COLORS.ENDC}").lower()

        if usr_input == "y":
            os.rename(pdf, rename_output)
            print("Done hai boss!")
        elif usr_input == "r":
            usr_rename = input("Enter the name: ")
            if ".pdf" not in usr_rename:
                usr_rename = usr_rename + ".pdf"
                print(f"Renamed to {COLORS.BOLD}{COLORS.UNDERLINE}{usr_rename}{COLORS.ENDC}")
            os.rename(pdf, usr_input)
        elif usr_input == "n":
            print("Cool")


if len(sys.argv) == 2:
    rename_that_shiz(sys.argv[1])
elif len(sys.argv) == 1:
    for fl in os.listdir():
        if fl.endswith(".pdf"):
            rename_that_shiz(fl)
else:
    print(f"{COLORS.FAIL}\nYou are doing it worng{COLORS.ENDC}")

