FROM python:3.8.5

WORKDIR /code

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONBUFFERED 1

#RUN apk add --no-cache --virtual .build-geps gcc musl-dev postgresql-dev

RUN pip install --upgrade pip

COPY . .

#RUN pip install -r requirements.txt

RUN pip install -r requirements.txt && python3 manage.py collectstatic --noinput

RUN chmod +x ./bin/create_envfile.sh

RUN bash ./bin/create_envfile.sh

CMD gunicorn api_yamdb.wsgi:application --bind 0.0.0.0:8000