#!python3.8

import subprocess as sp
import os
import sys
from multiprocessing import Pool, Process

try:
    from colorama import Fore, Style
except ImportError:
    print("you need to install colorama python module")
    colorama_ans = input("Do you want to?: [y/N]").lower()
    if colorama_ans == "y":
        sp.run(['pip3', 'install', 'colorama'])

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


def get_pdf_title(pdf):
    proc = sp.run(['pdftitle', '-p', pdf], stdout=sp.PIPE)
    output = proc.stdout.decode('utf-8').replace('\n', '').replace(':', " -") + ".pdf"
    print({pdf: output})
    return {pdf: output}

def rename_pdf(pdf, new_name):
    
    if new_name == '' or new_name == ".pdf":
        print(f"\n{Fore.YELLOW}Cant Find the name for {FORMAT.BOLD}{FORMAT.UNDERLINE}{pdf}{FORMAT.ENDC}{Fore.YELLOW}{FORMAT.ENDC}")
    elif new_name == pdf:
        print(f"\n{Fore.WHITE}You have the name for {FORMAT.BOLD}{FORMAT.UNDERLINE}{pdf}{FORMAT.ENDC}{Fore.WHITE} already!{FORMAT.ENDC}")
    else:
        usr_input = input(f"\n{FORMAT.UNDERLINE}Do you want to Rename:{FORMAT.ENDC} \n{Fore.BLUE}{pdf} -> {Fore.GREEN}{new_name}{FORMAT.ENDC} {FORMAT.BOLD}[y/N/r]: {FORMAT.ENDC}").lower()

        if usr_input == "y":
            os.rename(pdf, new_name)
            print("Done hai boss!")
        elif usr_input == "r":
            usr_rename = input("Enter the name: ")
            if ".pdf" not in usr_rename:
                usr_rename = usr_rename + ".pdf"
                print(f"Renamed to {FORMAT.BOLD}{FORMAT.UNDERLINE}{usr_rename}{FORMAT.ENDC}")
            os.rename(pdf, usr_input)
        elif usr_input == "n":
            print("Cool")

if __name__ == '__main__':

    if len(sys.argv) == 2:
        pdf = sys.argv[1]
        new_name = get_pdf_title(pdf)
        rename_pdf(pdf, new_name)
    elif len(sys.argv) == 1:
        print("Scanning all pdfs in the current directory...\n" )
        pdfs = [pdf for pdf in os.listdir() if pdf.endswith(".pdf")]
        with Pool(os.cpu_count()) as pool:
            list(pool.map(get_pdf_title, pdfs))
    else:
        print(f"{Fore.RED}\nYou are doing it worng{FORMAT.ENDC}")
