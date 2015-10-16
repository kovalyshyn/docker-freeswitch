## Supported tags and respective Dockerfile links

- `latest` ([Dockerfile](https://github.com/kovalyshyn/docker-freeswitch/blob/master/Dockerfile))
- `vanilla` ([Dockerfile](https://github.com/kovalyshyn/docker-freeswitch/blob/vanilla/Dockerfile))

## FreeSWITCH

[FreeSWITCH](http://www.freeswitch.org/) docker image

- Current version is `1.4.23`

### Default FreeSWITCH image

To run default FreeSWITCH with vanilla config, default music on hold and english sound files, just type:

	docker run -d -t --name=en webitel/freeswitch-sound:en
	docker run -d -t --name=moh webitel/freeswitch-sound:moh
	docker run -d -t --name=FS --volumes-from moh --volumes-from en --net="host" webitel/freeswitch-base:vanilla


### FreeSWITCH client
	
	docker run -i --rm --net="host" -t webitel/freeswitch-base:vanilla fs_cli

## Supported Docker versions

This image is officially supported on Docker version `1.8.3` and newest.

## User Feedback

### Issues
If you have any problems with or questions about this image, please contact us through a [Issues and Feature Requests](https://my.webitel.com/).
