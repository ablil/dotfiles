#!/usr/bin/env python3
# description: Ask Gemini AI to look into your git diff and generate a commit message for you

import subprocess
import sys
import os
import utils
from pydantic import BaseModel
import aiutils
import tempfile
import json
from typing import Optional

logger = utils.create_logger(__name__)

__prompt = """
You are tasked with generating a commit message and a description for the following code changes.
Keep it short and concise, and follow the conventional commits format.

Code changes:


"""

class StructuredOutput(BaseModel):
    commit_msg: str
    commit_description: Optional[str]


def commit(msg: StructuredOutput):
    commit_message_file = os.path.join(tempfile.gettempdir(), 'message.txt')
    with open(commit_message_file, 'w') as f:
        f.write(msg.commit_msg)
        f.write("\n\n")
        f.write(msg.commit_description)

    try:
        result = subprocess.run(
            ['git', 'commit', '-F', str(commit_message_file)],
            capture_output=True,
            text=True,
            check=True
        )
        logger.info(result.stdout)  # Output commit result
        os.remove(commit_message_file)  # Clean up the temporary file
    except subprocess.CalledProcessError as e:
        logger.error(f"Error committing changes: {e.stderr}")
        sys.exit(1)

def prompt_user(staged: bool = True):
    diff = utils.git_diff(staged)
    prompt = aiutils.Prompt(
        prompt=__prompt + diff,
        response_schema=StructuredOutput
    )
    message = aiutils.gemini_chat(prompt)
    logger.highlight(f"{message.commit_msg}\n\n{message.commit_description}")

    choice = input(f"""n\nDo you want to commit with this message [y/n/r(retry)]: """).lower().strip()
    if choice == 'y' or not len(choice):
        commit(message)
    elif choice == 'n':
        msg = input("Type your new message: ")
        commit(msg)
    elif choice == 'retry' or choice == 'r':
        prompt_user()
    else:
        logger.error("Invalid option, aborting.")
        sys.exit(0)

if __name__ == '__main__':
    prompt_user()
