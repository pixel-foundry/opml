// swift-tools-version:5.3
import PackageDescription

let package = Package(
	name: "OPML",
	products: [
		.library(name: "OPML", targets: ["OPML"])
	],
	targets: [
		.target(name: "OPML"),
		.testTarget(
			name: "Tests",
			dependencies: ["OPML"],
			resources: [.copy("Resources/feedly.opml"), .copy("Resources/rsparser.opml")]
		)
	]
)
