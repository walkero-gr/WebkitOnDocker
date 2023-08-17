local buildManifest(_tag, _tagName, _event) = {
	"kind": 'pipeline',
	"type": 'docker',
	"name": 'manifest-' + _tagName,
	"steps": [
		{
			"name": 'build-manifest',
			"pull": 'always',
			"image": 'plugins/manifest',
			"settings": {
				"target": 'walkero/webkitondocker:' + _tag,
				"template": 'walkero/webkitondocker:' + _tag + '-ARCH',
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
			"include": _event
		}
	},
	"depends_on": [
		'build-' + _tagName + '-amd64',
		'build-' + _tagName + '-arm64'
	]
};

{
	latest: buildManifest('latest', 'latest', ['push']),
	droneTag: buildManifest('${DRONE_TAG/\//-}', 'bytag', ['tag']),
}