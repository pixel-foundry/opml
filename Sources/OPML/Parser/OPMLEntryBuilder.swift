final class OPMLEntryBuilder {

	/// What is displayed when an outliner opens the OPML file.
	var text: String?
	var attributes: [OPMLAttribute]?
	var children: [OPMLEntryBuilder]?

	var entry: OPMLEntry? {
		guard let text = text else { return nil }
		return OPMLEntry(text: text, attributes: attributes, children: children?.compactMap { $0.entry })
	}

	init(text: String? = nil, attributes: [OPMLAttribute]? = nil, children: [OPMLEntryBuilder]? = nil) {
		self.text = text
		self.attributes = attributes
		self.children = children
	}

}
