# Snowmix Docker

## Docker 

To run Snowmix you just need to create a `snowmix.ini` and then set the volume of `/snowmix` to that directory: 

```sh
docker run --rm -v "$(pwd):/snowmix" -v "$(pwd)/tmp:/tmp" -it --shm-size=256m rojo2/snowmix
```

## Docker compose

```yaml
version: '3.8'
services:

  snowmix:
    image: rojo2/snowmix:latest
    shm_size: '256m'
    volumes:
      - .:/snowmix
```

Made with :heart: by [rojo2](https://rojo2.com)
