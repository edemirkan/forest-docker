# The Forest Dedicated Server Image
Dedicated server of The Forest on Ubuntu. The server software of The Forest is only available on Windows and therefore running with Wine in this image. 


## Configuration

The configuration of the server can be done in the [`server.cfg`](config/server.cfg)
file. The settings can be overwritten by copying a custom version to
`/data/config/server.cfg` or changing the config file and rebuilding the image.


### Sample compose.yml:

```yaml
services:
  forest-server:
    image: ghcr.io/edemirkan/forest-docker:latest
    container_name: forest_server
    cap_add:
      - sys_nice
    volumes:
      - "./saves:/data/saves"
      - "./server.cfg:/data/config/server.cfg"
    ports:
      - 0.0.0.0:8766:8766/udp
      - 0.0.0.0:8766:8766/tcp
      - 0.0.0.0:27015:27015/udp
      - 0.0.0.0:27015:27015/tcp
      - 0.0.0.0:27016:27016/udp
      - 0.0.0.0:27016:27016/tcp
    restart: unless-stopped
```