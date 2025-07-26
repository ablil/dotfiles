#!/usr/bin/env python3
# description: Ask Gemini AI to write some tests for your

import sys
from typing import Optional

from pydantic import BaseModel
from rich.console import Console
from rich.markdown import Markdown

import aiutils
import utils

logger = utils.create_logger(__name__)

__prompt = """
You are senior software engineer, you are tasked with writing unit tests for some code change.
Cover at least the happy path scenarios and add any necessary other scenarios

Here is the Git diff:


"""


class StructuredOutput(BaseModel):
    commit_msg: str
    commit_description: Optional[str]


def generate_tests(files, staged: bool = True) -> None:
    code_changes = ""

    # parse content of files
    if len(files):
        for file in files:
            with open(file, 'r') as fd:
                code_changes += fd.read()
    else:
        code_changes = utils.git_diff(staged)

    prompt = aiutils.Prompt(
        prompt=__prompt + code_changes,
        response_schema=None
    )
    result = aiutils.gemini_chat(prompt)

    console = Console()
    md = Markdown(result)
    console.print(md)


if __name__ == '__main__':
    # get files if provided
    files = []
    if len(sys.argv) > 1:
        files.extend(sys.argv[1:])

    generate_tests(files)
