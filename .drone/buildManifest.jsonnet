local buildManifest(_tag) = 
	local _tagName = if _tag == 'latest' then 
		'latest' 
	else 
		'bytag';

	{
		"kind": 'pipeline',
		"type": 'docker',
		"name": (if _tag == 'latest' then 'manifest-latest' else 'manifest-bytag'),
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
		"depends_on": (if _tag == 'latest' then ['build-latest-amd64', 'build-latest-arm64'] else ['build-bytag-amd64', 'build-bytag-arm64'])
	};

{
	latest: buildManifest('latest'),
	droneTag: buildManifest('${DRONE_TAG/\//-}'),
}