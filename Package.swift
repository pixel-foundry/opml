// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "OPML",
    products: [
        .library(name: "OPML", targets: ["OPML"])
    ],
    dependencies: [
        .package(name: "Html", url: "https://github.com/hallee/swift-html.git", from: "0.3.0")
    ],
    targets: [
        .target(name: "OPML", dependencies: ["Html"]),
        .testTarget(
            name: "OPMLTests",
            dependencies: ["OPML"],
            resources: [
                // Copy Tests/ExampleTests/Resources directories as-is.
                // Use to retain directory structure.
                // Will be at top level in bundle.
                .copy("Resources/rsparser.opml"),
                .copy("Resources/feedly.opml")
            ]
        )
    ]
)
