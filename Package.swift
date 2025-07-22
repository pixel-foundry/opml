// swift-tools-version:5.5
import PackageDescription

let package = Package(
	name: "OPML",
	platforms: [
		.iOS(.v14),
		.macOS(.v11),
		.tvOS(.v14),
	],
	products: [
		.library(name: "OPML", targets: ["OPML"])
	],
	dependencies: [
		.package(name: "Html", url: "https://github.com/pointfreeco/swift-html", from: "0.4.1")
	],
	targets: [
		.target(name: "OPML", dependencies: ["Html"]),
		.testTarget(
			name: "OPMLTests",
			dependencies: ["OPML"],
			resources: [.process("Resources")]
		)
	]
)
