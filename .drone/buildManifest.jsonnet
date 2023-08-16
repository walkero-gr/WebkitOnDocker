local buildManifest() = {
	"kind": 'pipeline',
	"type": 'docker',
	"name": 'manifest-webkitondocker-latest',
	"steps": [
		{
			"name": 'build-manifest',
			"pull": 'always',
			"image": 'plugins/manifest',
			"settings": {
				"target": 'walkero/webkitondocker:latest',
				"template": 'walkero/webkitondocker:latest-ARCH',
				"platforms": [
					'linux/amd64',
					'linux/arm64'
				],
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
		'build-webkitondocker-amd64',
		'build-webkitondocker-arm64'
	]
};

{
	webkitondocker: buildManifest(),
}