#!/usr/bin/env python

import os
from google import genai
from pydantic import BaseModel
import dataclasses
from typing import Optional
import utils

logger = utils.create_logger(__name__)

COMMIT_MESSAGE_PROMPT = """
You are tasked with generating a commit message and a description for the following code changes.
Keep it short and concise, and follow the conventional commits format.

Code changes:


"""

@dataclasses.dataclass
class Prompt:
    prompt: str
    response_schema: Optional[BaseModel]
    filepath: Optional[str] = None

def gemini_client(apikey: str = os.environ['GEMINI_API_KEY']) -> genai.Client:
    return genai.Client(api_key=apikey)


def gemini_chat(prompt: Prompt, client = gemini_client()) -> str | BaseModel:
    logger.info("Asking Gemini ...")
    config = None
    if prompt.response_schema:
        config={
            'response_mime_type': 'application/json',
            'response_schema': prompt.response_schema
        }

    response = client.models.generate_content(
        model='gemini-2.5-flash',
        contents=prompt.prompt,
        config=config
    )

    # return structured output if provided
    if prompt.response_schema:
        return prompt.response_schema.model_validate_json(response.text)

    return response.text
