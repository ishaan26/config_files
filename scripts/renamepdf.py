#!python3.8

import subprocess as sp
import os
import sys
try:
    from colorama import Fore, Style
except ImportError:
    print("you need to install colorama python module")
    colorama_ans = input("Do you want to?: [y/N]").lower()
    if colorama_ans == "y":
        sp.run(['pip3', 'install', 'colorama'])
    from colorama import Fore, Style
    
class FORMAT:
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


# Check if pdftitle exists
try:
    sp.run(['pdftitle'], stderr=sp.PIPE)
except FileNotFoundError:
    print("\nFirst install pdftitle 'pip3 install pdftitle'")
    install_ans = input("\nDo you want to? [y/N]: ").lower()
    if install_ans == "y":
        sp.run(['pip3', 'install', 'pdftitle'])


def rename_that_shiz(pdf):

    proc = sp.run(['pdftitle', '-p', pdf], stdout=sp.PIPE)
    rename_output = proc.stdout.decode('utf-8').replace('\n', '').replace(':', " -") + ".pdf"

    if rename_output == '' or rename_output == ".pdf":
        print(f"\n{Fore.YELLOW}Cant Find the name for {FORMAT.BOLD}{FORMAT.UNDERLINE}{pdf}{FORMAT.ENDC}{Fore.YELLOW}{FORMAT.ENDC}")
    elif rename_output == pdf:
        print(f"\n{Fore.WHITE}You have the name for {FORMAT.BOLD}{FORMAT.UNDERLINE}{pdf}{FORMAT.ENDC}{Fore.WHITE} already!{FORMAT.ENDC}")
    else:
        usr_input = input(f"\n{FORMAT.UNDERLINE}Do you want to Rename:{FORMAT.ENDC} \n{Fore.BLUE}{pdf} -> {Fore.GREEN}{rename_output}{FORMAT.ENDC} {FORMAT.BOLD}[y/N/r]: {FORMAT.ENDC}").lower()

        if usr_input == "y":
            os.rename(pdf, rename_output)
            print("Done hai boss!")
        elif usr_input == "r":
            usr_rename = input("Enter the name: ")
            if ".pdf" not in usr_rename:
                usr_rename = usr_rename + ".pdf"
                print(f"Renamed to {FORMAT.BOLD}{FORMAT.UNDERLINE}{usr_rename}{FORMAT.ENDC}")
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
    print(f"{Fore.RED}\nYou are doing it worng{FORMAT.ENDC}")
