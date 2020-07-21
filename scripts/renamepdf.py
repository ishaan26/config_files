#!python3.8

import subprocess as sp
import os
import sys
from multiprocessing import Pool

try:
    from colorama import Fore
except ImportError:
    print("you need to install colorama python module")
    colorama_ans = input("Do you want to?: [y/N]").lower()
    if colorama_ans == "y":
        sp.run(['pip3', 'install', 'colorama', '--user'])
    from colorama import Fore

try:
    import tqdm
except ImportError:
    print("you need to install tqdm python module")
    tqdm_ans = input("Do you want to?: [y/N]").lower()
    if tqdm_ans == "y":
        sp.run(['pip3', 'install', 'tqdm', '--user'])
    import tqdm

# Check if pdftitle exists
try:
    sp.run(['pdftitle'], stderr=sp.PIPE)
except FileNotFoundError:
    print("\nFirst install pdftitle 'pip3 install pdftitle'")
    install_ans = input("\nDo you want to? [y/N]: ").lower()
    if install_ans == "y":
        sp.run(['pip3', 'install', 'pdftitle'])


class FORMAT:
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


def get_pdf_title(pdf):
    proc = sp.run(['pdftitle', '-p', pdf], stdout=sp.PIPE)
    output = proc.stdout.decode('utf-8')
    output = output.replace('\n', '').replace(':', " -").replace('/', ' - ') + ".pdf"
    return {pdf: output}


def rename_pdf(pdf, new_name):
    if new_name == '' or new_name == ".pdf":
        print(f"\n{Fore.YELLOW}Cant Find the name for {FORMAT.BOLD}{FORMAT.UNDERLINE}{pdf}{FORMAT.ENDC}{Fore.YELLOW}{FORMAT.ENDC}")
    elif new_name == pdf:
        print(f"\n{Fore.WHITE}You already have the name for {FORMAT.BOLD}{FORMAT.UNDERLINE}{pdf}{FORMAT.ENDC}{Fore.WHITE} already!{FORMAT.ENDC}")
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
        new_name = list(new_name.values())[0]
        rename_pdf(pdf, new_name)

    elif len(sys.argv) == 1:
        print("Scanning all pdfs in the current directory...\n" )
        pdfs_curr_dir = [pdf for pdf in os.listdir() if pdf.endswith(".pdf")]

        # Process all pdfs first using all the cores on the machine
        # By doing this, there is only an inital waiting time and not in between confirmations 
        with Pool(os.cpu_count()) as pool:
            renamed_pdfs_dicts = list(tqdm.tqdm(pool.imap(get_pdf_title, pdfs_curr_dir), total=len(pdfs_curr_dir))) # list of dictionaries

        for n, data in enumerate(renamed_pdfs_dicts):
            pdf = list(data.keys())[0]
            new_name= list(data.values())[0]
            rename_pdf(pdf, new_name)
    else:
        print(f"{Fore.RED}\nYou are doing it worng{FORMAT.ENDC}")

