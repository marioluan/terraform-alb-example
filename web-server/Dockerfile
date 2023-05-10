FROM python:3.10-bullseye

WORKDIR "/app"

# install dependencies
COPY "Pipfile.lock" .
RUN pip3 install pipenv
RUN pipenv requirements > "requirements.txt"
RUN pip3 install -r "requirements.txt"

# app code
COPY "src" "src"

HEALTHCHECK CMD curl --fail localhost/healthcheck || exit -1

CMD [ "python3", "-m", "uvicorn", "src.server.api:app", "--port", "80", "--host", "0.0.0.0" ]