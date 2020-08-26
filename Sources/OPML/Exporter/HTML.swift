import Html

extension Node {

	static var xml: Node {
		.raw(#"<?xml version="1.0" encoding="UTF-8"?>"#)
	}

	static func opml(version: String, _ content: Node...) -> Node {
		.element("opml", [("version", version)], .fragment(content))
	}

	static func head(attributes: [(String, String)] = [], _ content: [Node]) -> Node {
		.element("head", attributes, .fragment(content))
	}

	static func title(attributes: [(String, String)] = [], _ content: Node...) -> Node {
		.element("title", attributes, .fragment(content))
	}

	static func dateCreated(attributes: [(String, String)] = [], _ content: Node...) -> Node {
		.element("dateCreated", attributes, .fragment(content))
	}

	static func dateModified(attributes: [(String, String)] = [], _ content: Node...) -> Node {
		.element("dateModified", attributes, .fragment(content))
	}

	static func ownerName(attributes: [(String, String)] = [], _ content: Node...) -> Node {
		.element("ownerName", attributes, .fragment(content))
	}

	static func ownerEmail(attributes: [(String, String)] = [], _ content: Node...) -> Node {
		.element("ownerEmail", attributes, .fragment(content))
	}

	static func ownerID(attributes: [(String, String)] = [], _ content: Node...) -> Node {
		.element("ownerId", attributes, .fragment(content))
	}

	static func docs(attributes: [(String, String)] = [], _ content: Node...) -> Node {
		.element("docs", attributes, .fragment(content))
	}

	static func body(attributes: [(String, String)] = [], _ content: [Node]) -> Node {
		.element("body", attributes, .fragment(content))
	}

	static func outline(attributes: [(String, String)] = [], _ content: [Node]) -> Node {
		.element("outline", attributes, .fragment(content))
	}

}
