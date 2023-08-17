local buildMain(_arch='amd64', _tag) = {
	"kind": 'pipeline',
	"type": 'docker',
	"name": (if _tag == 'latest' then 'build-latest-' + _arch else 'build-bytag-' + _arch),
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
					_tag + '-' + _arch
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
				(if _tag == 'latest' then 'push' else 'tag')
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
	latest: {
		amd64: buildMain('amd64', 'latest'),
		arm64: buildMain('arm64', 'latest')
	},
	droneTag: {
		amd64: buildMain('amd64', '${DRONE_TAG/\//-}'),
		arm64: buildMain('arm64', '${DRONE_TAG/\//-}')
	}
}