FROM python:3.8.5
WORKDIR /code
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONBUFFERED 1
COPY . .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt && python manage.py collectstatic --noinput
CMD gunicorn api_yamdb.wsgi:application --bind 0.0.0.0:8000