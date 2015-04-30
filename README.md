## Supported tags and respective Dockerfile links

- `latest` ([Dockerfile](https://github.com/kovalyshyn/docker-freeswitch/blob/master/Dockerfile))
- `vanilla` ([Dockerfile](https://github.com/kovalyshyn/docker-freeswitch/blob/vanilla/Dockerfile))

## FreeSWITCH

[FreeSWITCH](http://www.freeswitch.org/) docker image

- Current version is `1.4.18`

### Default FreeSWITCH image

To run default FreeSWITCH with vanilla config (included `mod_bcg729`), just type:

	docker run -d -t --name=FS --privileged=true --net="host" webitel/freeswitch-base:vanilla

### FreeSWITCH client
	
	docker run -i -t --name=cli webitel/freeswitch-base fs_cli -H 10.133.230.138


## Supported Docker versions

This image is officially supported on Docker version `1.6` and newest.

## User Feedback

### Issues
If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/kovalyshyn/docker-freeswitch/issues).