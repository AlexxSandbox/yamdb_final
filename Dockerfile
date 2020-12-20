FROM python:3.8.5
WORKDIR /code
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONBUFFERED 1
COPY . /code
RUN pip install --upgrade pip
RUN pip install -r /code/requirements.txt && python3 manage.py makemigrations && python3 manage.py migrate && python3 manage.py collectstatic --noinput
CMD gunicorn api_yamdb.wsgi:application --bind 0.0.0.0:8000