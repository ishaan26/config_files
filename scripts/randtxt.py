#!python3.8

import random
import string
import sys
import multiprocessing
import os
import subprocess as sp

try:
    import tqdm
except ImportError:
    print("You need to install tqdm python module")
    tqdm_ans = input("Do you want to?: [y/N]").lower()
    if tqdm_ans == "y":
        sp.run(['pip3', 'install', 'tqdm', '--user'])
    import tqdm

try:
    from colorama import Fore, Style
except ImportError:
    print("You need to install colorama python module")
    colorama_ans = input("Do you want to?: [y/N]").lower()
    if colorama_ans == "y":
        sp.run(['pip3', 'install', 'colorama', '--user'])
    from colorama import Fore, Style


LETTERS = string.printable
MEMORY_LIMIT = 100000000


def split(x, n):
    result = []
    if (x < n):
        return -1
    elif (x % n == 0):
        for i in range(n):
            result.append(x//n)
        return result
    else:
        zp = n - (x % n)
        pp = x//n
        for i in range(n):
            if(i>= zp):
                result.append(pp + 1)
            else:
                result.append(pp)
        return result


def gen_function(num, bar_position):
    if num > MEMORY_LIMIT:
        with open ("rand.txt", "a") as txt:
            for i in tqdm.tqdm(range(num), position=bar_position, leave=False):
                txt.write(random.choice(LETTERS))
    else:
        generated_text = ''.join(tqdm.tqdm(random.choices(LETTERS, k=num), position=bar_position))
        with open("rand.txt", "a") as txt:
            txt.write(generated_text)


if __name__ == '__main__':
    if len(sys.argv) == 1:
        os.system('cat /dev/urandom | base64 | pv >> rand.txt')
    elif len(sys.argv) == 2:
        cpus = os.cpu_count()
        num_to_generate = int(sys.argv[1])
        divided_input = split(num_to_generate, cpus)

        print("Starting genrating porcess. Please Wait...\n")

        if num_to_generate > MEMORY_LIMIT:
            print(f"""{Fore.YELLOW}The number to generate is out of memory range.
            Therefore, a slower method will be used to generate random text.""")

            print(f"Use randtxt without any arguments to generate fast random txt with no limit.{Fore.WHITE}")

        processes = []
        for i in range(0, cpus):
            p = multiprocessing.Process(target=gen_function, args=(divided_input[i], i))
            processes.append(p)
            p.start()
        for process in processes:
            p.join()
    else:
        print("You are doing it wrong")


