// swift-tools-version:5.3
import PackageDescription

let package = Package(
	name: "OPML",
	products: [
		.library(name: "OPML", targets: ["OPML"])
	],
	dependencies: [
		.package(name: "Html", url: "https://github.com/pointfreeco/swift-html.git", from: "0.3.0")
	],
	targets: [
		.target(name: "OPML", dependencies: ["Html"]),
		.testTarget(
			name: "Tests",
			dependencies: ["OPML"],
			resources: [.copy("Resources/feedly.opml"), .copy("Resources/rsparser.opml")]
		)
	]
)