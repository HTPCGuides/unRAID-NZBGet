# unRAID NZBGet
This is a Dockerfile to set up for [NZBGet](http://nzbget.net/), specially made for unRAID.

## Instructions
### Getting the docker image
Build from docker file

```
git clone git@github.com:htpcguides/unraid-nzbget.git
cd docker-nzbget
docker build -t htpcguides/unraid-nzbget .
```

You can also obtain it via:

```
docker pull htpcguides/unraid-nzbget
```

### Running the docker image
Instructions to run:

```
docker rm -f unraid-nzbget
docker run --restart=always -d --name unraid-nzbget -h *your_host_name* -v /*your_config_location*:/config -v /*your_downloads_folder_location*:/unraid -p 6789:6789 htpcguides/unraid-nzbget
```