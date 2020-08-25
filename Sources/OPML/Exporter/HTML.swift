import Html

extension Node {

	static var xml: Node {
		.raw(#"<?xml version="1.0" encoding="UTF-8"?>"#)
	}

	static func opml(version: String, _ content: Node...) -> Node {
		.element("opml", [("version", version)], .fragment(content))
	}

	static func head(attributes: [(String, String)] = [], _ content: Node...) -> Node {
		.element("head", attributes, .fragment(content))
	}

	static func title(attributes: [(String, String)] = [], _ content: Node...) -> Node {
		.element("title", attributes, .fragment(content))
	}

	static func body(attributes: [(String, String)] = [], _ content: [Node]) -> Node {
		.element("body", attributes, .fragment(content))
	}

	static func outline(attributes: [(String, String)] = [], _ content: [Node]) -> Node {
		.element("outline", attributes, .fragment(content))
	}

}
