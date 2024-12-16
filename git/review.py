#!/usr/bin/env python3
# description: Ask Gemini AI to look into your git diff and review it

import subprocess
import sys
import os
from dis import code_info
import dataclasses
import functools
import argparse

import google.generativeai as genai
import tempfile

__prompt = """
Act as a senior software engineer, and you are tasked to review pull request from one of your peer, given only the Git diff.
Review the following Git diff and provide actionable feedback on the changes if needed, otherwise respond with 'N/A'.
Do not review the unchanged code, and avoid unnecessary explanations—just actionable feedback on the modifications.
Provide review in a friendly tone, which can be copied and pasted directly into the pull request.

Here is the git diff for the changes:
"""

__file_to_ignore = [
    'poetry.lock',
    '.gitignore',
    '.dockerignore',
    '.python-version',
    'README.md'
]

def get_all_changed_files(current_branch = 'HEAD', main_branch = 'main' ,only: list[str]|None = None) -> list[ str ]:
    try:
        result = subprocess.run(
            ['git', 'diff', main_branch, current_branch, '--name-only'],
            capture_output=True,
            text=True,
            check=True
        )
        filenames =  result.stdout.split('\n')
        changed_files = list(filter(lambda filename: not any(filename.endswith(file_to_exclude) for file_to_exclude in __file_to_ignore), filenames))

        if only:
            return list(filter(lambda filename: any(filename.endswith(file) for file in only), changed_files))
        return changed_files
    except subprocess.CalledProcessError as e:
        print(f"Error getting changed files from {current_branch} against {main_branch}, {e.stderr}")
        sys.exit(1)
    

def git_diff(filename: str, branch = 'HEAD', main = 'main') -> str:
    try:
        result = subprocess.run(
            ['git', 'diff', main, branch, '--', filename],
            capture_output=True,
            text=True,
            check=True
        )
        return result.stdout
    except subprocess.CalledProcessError as e:
        print(f"Error getting git diff for file {filename}: {e.stderr}")
        sys.exit(1)


def __configure_credentials(api_key: str = os.environ.get('GEMINI_API_KEY')):
    if not api_key:
        raise ValueError("GEMINI_API_KEY environment variable is not set or is empty.")
    genai.configure(api_key=api_key)

@functools.cache
def get_model():
    __configure_credentials()
    return genai.GenerativeModel("gemini-1.5-flash")

def press_any_key_to_continue():
    print("Press any key to continue...")
    if os.name == 'nt':  # For Windows
        import msvcrt
        msvcrt.getch()
    else:  # For Unix/Linux/Mac
        import sys, tty, termios
        fd = sys.stdin.fileno()
        old_settings = termios.tcgetattr(fd)
        try:
            tty.setraw(sys.stdin.fileno())
            sys.stdin.read(1)
        finally:
            termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)

def review(filename: str, diff: str, interactive_mode = False):
    print(f"reviewing {filename} ...")
    review_file = os.path.join('.review', filename.split('/')[-1])
    try:
        response = get_model().generate_content(f"{__prompt}\n\n{diff}")
        if interactive_mode:
            print(f"\n\n{response.text}\n\n")
            press_any_key_to_continue()
        else:
            with open(review_file, 'w') as fd:
                fd.write(response.text)
    except Exception as e:
        print(f"failed to review {filename}, {e}")

def cli():
    parser = argparse.ArgumentParser(prog='review', description='Ask Gemini to review pull requests locally', epilog='Before running, make sure you have switch to the branch you want to review')
    parser.add_argument('-f', '--file', help="review a specific file, support base name only (eg, NestedFile.kt)", action='append')
    parser.add_argument('--master', help="compare Git diff against master branch (default: main)", default='main', action='store_const', const='master') 
    parser.add_argument('-b', '--branch', help='review specific branch (default: HEAD)', default='HEAD')
    parser.add_argument('-i' ,'--interactive', help='run interative mode (default: save review on .review directory)', action='store_true')
    return parser.parse_args()

def main():
    args = cli()
    print(args)
    HEAD = args.branch
    main = args.master
    files =  args.file
    interactive_mode = args.interactive

    os.makedirs('.review', exist_ok=True)

    changed_files = get_all_changed_files(HEAD, main, files)
    print(f"total file to review {len(changed_files)}")
    for file in changed_files:
        diff = git_diff(file, HEAD, main)
        review(file, diff, interactive_mode)

if __name__ == '__main__':
    main()
