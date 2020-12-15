# YaMDb

![CI Status](https://github.com/AlexxSandbox/yamdb_final/workflows/YaMDB%20api%20workflow/badge.svg)
![Top language](https://img.shields.io/github/languages/top/AlexxSandbox/yamdb_final)
![GitHub last commit](https://img.shields.io/github/last-commit/AlexxSandbox/yamdb_final)
![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/alexxdockerhub/yamdb_app)

API service for movie reviews.

The YaMDb project collects reviews (Review) from users on works (Title). The works are divided into categories: "Books", "Films", "Music". The list of categories (Category) can be expanded (for example, you can add the category "Fine Arts" or "Jewelry").

The works themselves are not stored in YaMDb, you cannot watch a movie or listen to music here.

Each category contains works: books, films or music. For example, in the category "Books" there may be works "Winnie the Pooh and All, All, All" and "The Martian Chronicles", and in the category "Music" - the song "Now" by the group "Insects" and the second suite by Bach. A work can be assigned a genre from a list of preset ones (for example, "Fairy Tale", "Rock" or "Arthouse"). New genres can only be created by the administrator.

Grateful or outraged readers leave text reviews for the works (Review) and give the work a rating (an estimate in the range from one to ten). The average score of the work is automatically calculated from the set of ratings.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

What things you need to install the software and how to install them

* [Install Docker](https://docs.docker.com/engine/install/ubuntu/)
* [Install Docker-compose](https://docs.docker.com/compose/install/)

### How it work
Generate .env file:
* auto
```
$ sudo ./bin/create_enfile.sh
```
* manual
```
$ touch .env

$ DB_ENGINE=django.db.backends.postgresql
$ DB_NAME=*\<YOURKEY>\*
$ POSTGRES_USER=*\<YOUNAME>\*
$ POSTGRES_PASSWORD=*\<YOURPASSWORD>\*
$ DB_HOST=db
$ DB_PORT=5432
```
Build the new image and spin up the containers:
```
$ sudo docker-compose up -d --build
```
or
```
$ make dev
```
Ensure the default Django tables were created:
```
$ make exec c=db psql --username=postgres --dbname=postgres
```
```
psql (12.0)
Type "help" for help.

postgres=# \l
                                          List of databases
      Name       |    Owner     | Encoding |  Collate   |   Ctype    |       Access privileges
-----------------+--------------+----------+------------+------------+-------------------------------
postgres         | hello_django | UTF8     | en_US.utf8 | en_US.utf8 |
template0        | hello_django | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres              +
                 |              |          |            |            | postgres=CTc/postgres
template1        | hello_django | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres              +
                 |              |          |            |            | postgres=CTc/postgres
(3 rows)

postgres=# \dt
                     List of relations
 Schema |             Name              | Type  |  Owner   
--------+-------------------------------+-------+----------
 public | api_category                  | table | postgres
 public | api_comment                   | table | postgres
 public | api_genre                     | table | postgres
 public | api_review                    | table | postgres
 public | api_title                     | table | postgres
 public | api_title_genre               | table | postgres
 public | api_user                      | table | postgres
 public | api_user_groups               | table | postgres
 public | api_user_user_permissions     | table | postgres
 public | auth_group                    | table | postgres
 public | auth_group_permissions        | table | postgres
 public | auth_permission               | table | postgres
 public | django_admin_log              | table | postgres
 public | django_content_type           | table | postgres
 public | django_migrations             | table | postgres
 public | django_session                | table | postgres
 public | drfpasswordless_callbacktoken | table | postgres
(17 rows)

postgres=# \q
```
Create superuser for Django admin:
```
$ make exec
$ python manage.py createsuperuser
$ ...
```
Ready!
You can work with API. Run browser and get Token [localhost:8000/api/v1/auth/token](https://localhost:8000/api/v1/auth/token/)

*To delete all containers, volumes and networks run:
```
$ make down
```

## Built With

* [Django](https://docs.djangoproject.com/en/3.1/) - Web framework on Python
* [Django REST](https://www.django-rest-framework.org/) - The REST framework
* [drfpasswordless](https://pypi.org/project/drfpasswordless/) - Passwordless auth for Django Rest Framework Token Authentication
* [PostgreSQL](https://hub.docker.com/_/postgres) - The open source object-relation database
* [Gunicorn](https://gunicorn.org/) - Puthon WSGI HTTP Server  for Unix
* [nginx](https://hub.docker.com/_/nginx) - Nginx (pronounced "engine-x") is an open source reverse proxy server for HTTP, HTTPS, SMTP, POP3, and IMAP protocols, as well as a load balancer, HTTP cache, and a web server (origin server).
* [yamdb_api](https://hub.docker.com/r/alexxdockerhub/yamdb) - API service for movie reviews.

## Contributing

When contributing to this repository, please first discuss the change you wish to make via issue, email, or any other method with the owners of this repository before making a change.
Please note we have a code of conduct, please follow it in all your interactions with the project.

#### Pull Request Process

1. Ensure any install or build dependencies are removed before the end of the layer when doing a 
   build.
2. Update the README.md with details of changes to the interface, this includes new environment 
   variables, exposed ports, useful file locations and container parameters.
3. Increase the version numbers in any examples files and the README.md to the new version that this
   Pull Request would represent. The versioning scheme we use is [SemVer](http://semver.org/).
4. You may merge the Pull Request in once you have the sign-off of two other developers, or if you 
   do not have permission to do that, you may request the second reviewer to merge it for you

## Versioning

Latest versions available, see the [GitHub](https://github.com/AlexxSandbox/yamdb_final). 

## Authors

* **Aleksandr Sergeev** - *Custom user, JWT, registration, authentication, permissions* - [AlexxSandbox](https://github.com/AlexxSandbox/)
* **Ilya Evgrafov** - *Views and endpoint for Reviews and Comments. Rating for title* - [iljuevgrafov](https://github.com/iljuevgrafov/)
* **Georgiy Egorov** - *Views and endpoint for Categories, Genres, Titles* - [gordeev40k](https://github.com/gordeev40k)

## Acknowledgments

* Friends, searching in google and docs