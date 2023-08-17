local buildManifest(_tag) = {
	"kind": 'pipeline',
	"type": 'docker',
	"name": 'manifest-' + (if _tag == 'latest' then _tag else 'bytag'),
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
			"include": [
				(if _tag == 'latest' then 'push' else 'tag')
			]
		}
	},
	"depends_on": [
		'build-' + (if _tag == 'latest' then _tag else 'bytag') + '-amd64',
		'build-' + (if _tag == 'latest' then _tag else 'bytag') + '-arm64'
	]
};

{
	latest: buildManifest('latest'),
	droneTag: buildManifest('${DRONE_TAG}'),
}