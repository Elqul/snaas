# Tapglue SNAAS

The Tapglue Social Network As A Service.

# [System Overview](https://gist.github.com/mnemonicflow/f13a5beaf30d020026c24f92c8278781#what-is-tapglue)

# Install dependencies

## Golang
`go get -d -v ./...`

## Install Redis 
https://gist.github.com/jbgo/4155591

## Install PostgreSQL

# Docker

## Add user to docker group
sudo usermod -a -G docker $USER

## Build Docker container
`./infrastructure/scripts/build-container`

# Start a container and run the service
`sudo docker run -it --rm --net=host 411a61b03b81 sh -c "/tapglue/gateway-http -aws.id='' -aws.secret='' -aws.region='eu-west-1 -source=sqs' -postgres.url='host=localhost user=tapglue password=tapglue dbname=tapglue sslmode=disable connect_timeout=5'"`

Note: --net=host allows you to access the server from the host computer

# Connect to running container
`sudo docker exec -it 7c15c80cd0af sh`

# App token
`./dataz -data.dir=/home/neon/Projects/Go/src/github.com/tapglue/snaas/infrastructure/dataz_data -postgres.url='host=localhost user=tapglue password=tapglue dbname=tapglue sslmode=disable connect_timeout=5' import`

# Session token

- create user
curl -v -i -X POST \
    -u 2da2d79336c2773c630ce46f5d24cb76: \
    -H "User-Agent: Tapglue Test UA" \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d "{\"first_name\":\"Test\",\"last_name\":\"Account\",\"user_name\":\"Test\",\"email\":\"test@example.com\",\"social_ids\":{\"facebook\":\"234234234\"},\"password\":\"test\",\"metadata\":{\"foo\":\"bar\"},\"custom_id\":\"1\",\"images\":{\"avatar\":{\"url\":\"https://goo.gl/rMhFva\",\"height\":400,\"width\":400},\"avatar_thumb\":{\"url\":\"https://goo.gl/rMhFva\",\"height\":150,\"width\":150}}}" http://localhost:8083/0.4/users

```
{"about":"","custom_id":"1","email":"test@example.com","first_name":"Test","follower_count":0,"followed_count":0,"friend_count":0,"id":81699988857422507,"id_string":"81699988857422507","images":{"avatar":{"url":"https://goo.gl/rMhFva","type":"","height":400,"width":400},"avatar_thumb":{"url":"https://goo.gl/rMhFva","type":"","height":150,"width":150}},"is_follower":false,"is_followed":false,"is_friend":false,"last_name":"Account","metadata":{"foo":"bar"},"session_token":"ISpDa0hIISptclZiQ0QpKFZzQU8=","social_ids":{"facebook":"1660307610946390"},"user_name":"Test","created_at":"2017-03-17T09:03:28.148817869Z","updated_at":"2017-03-17T09:03:28.148817869Z"}
```

We got our session token: `ISpDa0hIISptclZiQ0QpKFZzQU8=`

- user info
```curl -v -i \
    -u 2da2d79336c2773c630ce46f5d24cb76:ISpDa0hIISptclZiQ0QpKFZzQU8= \
    -H "User-Agent: Tapglue Test UA" \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    http://localhost:8083/0.4/users/81699988857422507
```

- user login
```curl -vi \
    -u 2da2d79336c2773c630ce46f5d24cb76: \
    -H "User-Agent: Tapglue Test UA" \
    -H 'Accept: application/json' \
    -H "Content-Type: application/json" \
    -d '{"user_name": "Test", "password": "test"}' \
    http://localhost:8083/0.4/me/login
```

# SIMS
`./sims -aws.id='' -aws.secret='' -aws.region='' -postgres.url='host=localhost user=tapglue password=tapglue dbname=tapglue sslmode=disable connect_timeout=5'`
