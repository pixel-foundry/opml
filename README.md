# OPML

OPML is a Swift package for parsing and creating [OPML](http://dev.opml.org/spec2.html) files.

This package aims to create an opinionated, but strongly-typed and correct implementation of the OPML spec. For instance, the [OPML spec](http://dev.opml.org/spec2.html) defines some rarely-used properties related to the internal state of a hypothetical desktop application, like `vertScrollState` and `windowTop`, which this implementation deems unnecessary and omits.

## Usage

### Parsing OPML files

You can use `OPML` with either a file URL or data:

```swift
import OPML

let parser = try OPMLParser(file: fileURL)
let opml = try parser.parse() // OPML(version: "2.0", title: Optional("Feedly"), ...

// or, with data you’ve downloaded:

let parser = try OPMLParser(data)
let opml = try parser.parse() // OPML(version: "2.0", title: Optional("Feedly"), ...
```

### Creating and exporting OPML files

Create an `OPML` model from a list of RSS feed entries (or anything else, really).

`OPML` provides the `xml` property and `xml(indented: Bool)` function to export a string containing your rendered OPML XML.

```swift
import OPML

let rssFeeds = [...] // your RSS feed models

let opml = OPML(title: "RSS Feeds", entries: rssFeeds.map { feed -> OPMLEntry in
    OPMLEntry(rss: feed.url, title: feed.title)
})
let xml = opml.xml
// <?xml version="1.0" encoding="UTF-8"?><opml version="2.0"><head><title>RSS Feeds...
```

## Installation

SwiftPM:

```swift
dependencies: [
    .package(name: "OPML", url: "https://github.com/pixel-foundry/opml", from: "0.0.1")
],
targets: [
    .target(name: "YourTarget", dependencies: ["OPML"])
]
```
