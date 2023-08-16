local buildMain(_arch='amd64') = {
	"kind": 'pipeline',
	"type": 'docker',
	"name": 'build-webkitondocker-' + _arch,
	"platform": {
		"arch": _arch,
		"os": 'linux'
	},
	"steps": [
		{
			"name": 'build',
			"pull": 'always',
			"image": 'plugins/docker',
			"settings": {
				"repo": 'walkero/webkitondocker',
				"tags": [
					'latest-' + _arch
				],
				"cache_from": [
					'walkero/webkitondocker:latest'
				],
				"dockerfile": 'Dockerfile',
				"purge": true,
				// "dry_run": true,
				"compress": true,
				"username": {
					"from_secret": 'DOCKERHUB_USERNAME'
				},
				"password": {
					"from_secret": 'DOCKERHUB_PASSWORD'
				},
			}
		}
	],
	"trigger": {
		"branch": {
			"include": [
				'master',
				'main'
			]
		},
		"event": {
			"include": [
				'push'
			]
		}
	},
	"depends_on": [
		'awsbuilders-poweron'
	],
	"node": {
		"agents": 'awsbuilders'
	}
};

{
	webkitondocker: {
		amd64: buildMain('amd64'),
		arm64: buildMain('arm64')
	}
}