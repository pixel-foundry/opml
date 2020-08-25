import Html

public extension OPML {

	private var document: [Node] {
		[
			.xml,
			.opml(version: version,
				titleNode,
				.body(
					entries.map { $0.node }
				)
			)
		]

	}

	private var titleNode: Node {
		if let title = title {
			return .head(.title(.text(title)))
		}
		return .fragment([])
	}

	public var xml: String {
		render(document)
	}

}

extension OPMLEntry {

	var htmlAttributes: [(String, String)] {
		attributes?.compactMap {
			guard !$0.value.isEmpty else { return nil }
			return ($0.name, escapeTextNode(text: $0.value))
		} ?? []
	}

	var node: Node {
		.outline(attributes: htmlAttributes, children?.map { $0.node } ?? [])
	}

}
