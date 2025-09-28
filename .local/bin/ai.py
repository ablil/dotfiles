#!/usr/bin/env python3
"""
Unified AI developer tool: commit message generation, code review, and test suggestion using Gemini AI.

Usage:
  ai.py commit
  ai.py review [--output OUTPUT_FILE]
  ai.py test
"""
import argparse
import sys
import os
import tempfile
import utils
import aiutils
from pydantic import BaseModel
from typing import Optional
from rich.console import Console
from rich.markdown import Markdown

logger = utils.create_logger(__name__)

# --- Commit Message Generation ---
class CommitOutput(BaseModel):
    commit_msg: str
    commit_description: Optional[str]

def ai_commit(staged: bool = True):
    diff = utils.git_diff(staged)
    prompt = aiutils.Prompt(
        prompt="You are tasked with generating a commit message and a description for the following code changes.\nKeep it short and concise, and follow the conventional commits format.\n\nCode changes:\n\n" + diff,
        response_schema=CommitOutput
    )
    message = aiutils.gemini_chat(prompt)
    logger.highlight(f"{message.commit_msg}\n\n{message.commit_description}")
    choice = input("\nDo you want to commit with this message [y/n/r(retry)]: ").lower().strip()
    if choice == 'y' or not len(choice):
        commit_message_file = os.path.join(tempfile.gettempdir(), 'message.txt')
        with open(commit_message_file, 'w') as f:
            f.write(message.commit_msg)
            f.write("\n\n")
            if message.commit_description:
                f.write(message.commit_description)
        try:
            result = utils.subprocess.run(
                ['git', 'commit', '-F', str(commit_message_file)],
                capture_output=True,
                text=True,
                check=True
            )
            logger.info(result.stdout)
            os.remove(commit_message_file)
        except Exception as e:
            logger.error(f"Error committing changes: {e}")
            sys.exit(1)
    elif choice == 'retry' or choice == 'r':
        ai_commit(staged)
    else:
        logger.info("Aborted.")

# --- Code Review ---
def ai_review(output_file=None, staged: bool = True):
    diff = utils.git_diff(staged)
    prompt = aiutils.Prompt(
        prompt="You are a senior engineer. Review the following code diff:\n\n" + diff,
        response_schema=None
    )
    review = aiutils.gemini_chat(prompt)
    if output_file:
        with open(output_file, 'w') as f:
            f.write(review)
        logger.highlight(f"Review written to {output_file}")
    else:
        console = Console()
        md = Markdown(review)
        console.print(md)

# --- Test Generation ---
def ai_test(files=None, staged: bool = True):
    code_changes = ""
    if files:
        for file in files:
            with open(file, 'r') as fd:
                code_changes += fd.read()
    else:
        code_changes = utils.git_diff(staged)
    prompt = aiutils.Prompt(
        prompt="You are senior software engineer, you are tasked with writing unit tests for some code change.\nCover at least the happy path scenarios and add any necessary other scenarios\n\nHere is the Git diff:\n\n" + code_changes,
        response_schema=None
    )
    result = aiutils.gemini_chat(prompt)
    console = Console()
    md = Markdown(result)
    console.print(md)

def main():
    parser = argparse.ArgumentParser(description="Unified AI dev tool")
    subparsers = parser.add_subparsers(help='subcommands', dest='command')

    commit_parser = subparsers.add_parser('commit', help='generate commit message from code change')
    commit_parser.add_argument('-d', '--dirty', action='store_true', help='use dirty files (default: staged)')

    review_parser = subparsers.add_parser('review', help='review code and suggest improvements')
    review_parser.add_argument('--output', help='output markdown file')
    review_parser.add_argument('-d', '--dirty', action='store_true', help='use dirty files (default: staged)')

    test_parser = subparsers.add_parser('test', help='generate tests for code change')
    test_parser.add_argument('-f', '--files', nargs='*', help='list of files to read, if not provided, all changed files will be read', default=[])
    test_parser.add_argument('-d', '--dirty', action='store_true', help='use dirty files (default: staged)')

    args = parser.parse_args()
    if not args.command:
        parser.print_help()
        exit(1)

    if args.command == 'commit':
        ai_commit(not args.dirty)
    elif args.command == 'review':
        ai_review(output_file=args.output, staged=not args.dirty)
    elif args.command == 'test':
        ai_test(files=args.files, staged=not args.dirty)

if __name__ == '__main__':
    main()
