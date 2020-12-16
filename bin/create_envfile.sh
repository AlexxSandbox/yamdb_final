#!/bin/bash

if [[ ! -f `pwd`'/../.env' ]]; then

    function get_random {
        base=$(openssl rand -base64 16)
        base_clear=${base/+//}
        base_clear=${base_clear////}
        base_clear=${base_clear//=/}
        echo $base_clear
    }

    touch `pwd`'/.env'
    echo "SECRET_KEY=$(get_random)
DB_ENGINE=django.db.backends.postgresql
DB_NAME=$(get_random)
POSTGRES_USER=$(get_random)
POSTGRES_PASSWORD=$(get_random)
DB_HOST=db
DB_PORT=5432" > `pwd`'/.env'
fi

echo 'Done.'