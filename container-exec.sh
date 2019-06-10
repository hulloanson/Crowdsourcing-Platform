theuid=$( id -u ${user} )
docker container exec -u $theuid crowddung${mode}_api_1 /bin/bash -c "$1"
