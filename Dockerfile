FROM python:3.10-slim-bullseye

RUN apt-get update && apt-get install -y python3-pip && pip install pipenv
WORKDIR /script/

COPY Pipfile* /script/

RUN pipenv install --system --deploy

COPY ami_filter.py /script/ami_filter.py

ENTRYPOINT ["python", "ami_filter.py"]