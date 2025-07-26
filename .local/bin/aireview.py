#!/usr/bin/env python3
# description: Ask Gemini AI to critici a code changes

import sys
from typing import Optional

from pydantic import BaseModel
from rich.console import Console
from rich.markdown import Markdown

import aiutils
import utils

logger = utils.create_logger(__name__)

__prompt = """
You are senior software engineer, you are tasked to review some code changes, critic it, highlight potential bugs, or provide better approach if possible.

Here is the Git diff:


"""

class StructuredOutput(BaseModel):
    commit_msg: str
    commit_description: Optional[str]


def review_code_change(files, staged: bool = True) -> str:
    code_changes = ""
    
    # parse content of files
    if files and len(files):
        logger.info("parsing files ...")
        for file in files:
            with open(file, 'r') as fd:
                code_changes += fd.read()
    else:
        logger.info("getting changed files ...")
        code_changes = utils.git_diff(staged)

    prompt = aiutils.Prompt(
        prompt=__prompt + code_changes,
        response_schema=None
    )
    result =  aiutils.gemini_chat(prompt)

    console = Console()
    md = Markdown(result)
    console.print(md)

if __name__ == '__main__':  
    # get files if provided
    files = []
    if len(sys.argv) > 1:
        files.extend(sys.argv[1:])

    review_code_change(files)

