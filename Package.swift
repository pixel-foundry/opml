// swift-tools-version:5.0
import PackageDescription

let package = Package(
	name: "OPML",
	products: [
		.library(name: "OPML", targets: ["OPML"])
	],
	targets: [
		.target(name: "OPML"),
		.testTarget(name: "Tests", dependencies: ["OPML"])
	]
)
