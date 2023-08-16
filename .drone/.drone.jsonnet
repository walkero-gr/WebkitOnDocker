local awsbuilder = import '.drone/awsbuilders.jsonnet';
local buildManifest = import '.drone/buildManifest.jsonnet';
local buildMain = import '.drone/buildMain.jsonnet';

[
	awsbuilder['poweron'],
	buildMain.webkitondocker.amd64,
	buildMain.webkitondocker.arm64,
	buildManifest.webkitondocker
]
