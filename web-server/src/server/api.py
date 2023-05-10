import os

from fastapi import FastAPI

# This gets injected by Terraform when defining the container.
WEB_SERVER_NAME = os.environ.get("WEB_SERVER_NAME")

app = FastAPI()


@app.get("/", response_model=str)
def get_root() -> str:
    return f"Hello from {WEB_SERVER_NAME}."


@app.get("/healthcheck", response_model=str)
def healthcheck() -> str:
    return WEB_SERVER_NAME
