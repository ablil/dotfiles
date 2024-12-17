#!/usr/bin/env python3
# description: Ask Gemini AI to look into your git diff and generate a commit message for you

import subprocess
import sys
import os
from dis import code_info

import google.generativeai as genai
import tempfile

__prompt = """
Generate a concise and meaningful commit message based on the following git diff.
Summarize the purpose of the changes in a clear and professional tone, avoiding overly technical details.
Include context if evident, such as fixing bugs, adding features, improving performance, or refactoring code.
Here is the diff:
"""

def git_diff() -> str:
    try:
        result = subprocess.run(
            ['git', 'diff', '--staged'],
            capture_output=True,
            text=True,
            check=True
        )
        return result.stdout
    except subprocess.CalledProcessError as e:
        print(f"Error getting git diff: {e.stderr}")
        sys.exit(1)


def __configure_credentials(api_key: str = os.environ.get('GEMINI_API_KEY')):
    if not api_key:
        raise ValueError("GEMINI_API_KEY environment variable is not set or is empty.")
    genai.configure(api_key=api_key)

def generate_commit_message(diff: str) -> str:
    if not diff or not len(diff.strip()):
        print("make sure to add your files to staging area")
        sys.exit()
    __configure_credentials()
    model = genai.GenerativeModel("gemini-1.5-flash")
    response = model.generate_content(f"{__prompt}\n\n{diff}")
    return response.text

def commit(msg: str):
    commit_message_file = os.path.join(tempfile.gettempdir(), 'message.txt')
    with open(commit_message_file, 'w') as f:
        f.write(msg)

    try:
        result = subprocess.run(
            ['git', 'commit', '-F', str(commit_message_file)],
            capture_output=True,
            text=True,
            check=True
        )
        print(result.stdout)  # Output commit result
        os.remove(commit_message_file)  # Clean up the temporary file
    except subprocess.CalledProcessError as e:
        print(f"Error committing changes: {e.stderr}")
        sys.exit(1)

def __prompt_user():
    message = generate_commit_message(git_diff())
    choice = input(f"""{message}\n\nDo you want to commit with this message [y/n/r(retry)]: """).lower().strip()
    if choice == 'y' or not len(choice):
        commit(message)
    elif choice == 'n':
        msg = input("Type your new message: ")
        commit(msg)
    elif choice == 'retry' or choice == 'r':
        __prompt_user()
    else:
        print("Invalid option, aborting.")
        sys.exit(0)

if __name__ == '__main__':
    __prompt_user()
