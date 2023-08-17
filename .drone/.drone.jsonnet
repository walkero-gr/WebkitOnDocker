local awsbuilder = import '.drone/awsbuilders.jsonnet';
local buildManifest = import '.drone/buildManifest.jsonnet';
local buildMain = import '.drone/buildMain.jsonnet';

[
	awsbuilder['poweron'],
	buildMain.latest.amd64,
	buildMain.latest.arm64,
	buildManifest.latest,
	buildMain.droneTag.amd64,
	// buildMain.droneTag.arm64,
	// buildManifest.droneTag
]
