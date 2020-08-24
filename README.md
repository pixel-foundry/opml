# OPML

OPML is a Swift package for parsing and creating [OPML](http://dev.opml.org/spec2.html) files.

This package aims to create an opinionated, but strongly-typed and correct implementation of the OPML spec. For instance, the [OPML spec](http://dev.opml.org/spec2.html) defines some rarely-used properties related to the internal state of a hypothetical desktop application, like `vertScrollState` and `windowTop`, which this implementation deems unnecessary and omits.
