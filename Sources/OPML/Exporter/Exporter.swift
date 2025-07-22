import Foundation
import Html

public extension OPML {
	var xml: String {
		render(document)
	}

    // TODO: Reintroduce indentation when bugs are fixed. Currently doesn't escape attribute values.
//	func xml(indented: Bool) -> String {
//        if indented {
//			return debugRender(document, config: Config.pretty)
//		}
//		return xml
//	}

	private static let dateFormatter = DateFormatter.iso8601

	private var document: [Node] {
		[
			.xml,
			.opml(
				version: version,
				headNode,
				.body(entries.map { $0.node })
			)
		]

	}

	private var headNode: Node {
		var children = [Node]()
		if let title = title {
			children.append(.title(.text(title)))
		}
		if let dateCreated = dateCreated {
			children.append(.dateCreated(.text(OPML.dateFormatter.string(from: dateCreated))))
		}
		if let dateModified = dateModified {
			children.append(.dateModified(.text(OPML.dateFormatter.string(from: dateModified))))
		}
		if let ownerName = ownerName {
			children.append(.ownerName(.text(ownerName)))
		}
		if let ownerEmail = ownerEmail {
			children.append(.ownerEmail(.text(ownerEmail)))
		}
		if let ownerID = ownerID {
			children.append(.ownerID(.text(ownerID.absoluteString)))
		}
		if let docs = docs {
			children.append(.docs(.text(docs.absoluteString)))
		}
		return .head(children)
	}
}

extension OPMLEntry {
	var htmlAttributes: [(String, String)] {
		var htmlAttributes: [(String, String)] = attributes?.compactMap {
			guard !$0.value.isEmpty else { return nil }
			return ($0.name, escapeTextNode(text: $0.value))
		} ?? []
		htmlAttributes.append(("text", text))
		return htmlAttributes
	}

	var node: Node {
		.outline(attributes: htmlAttributes, children?.map { $0.node } ?? [])
	}
}

public extension OPMLEntry {
	var xml: String {
		render(node)
	}
}
