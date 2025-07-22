import Foundation

public struct OPMLEntry: Codable, Hashable {

	/// What is displayed when an outliner opens the OPML file.
	public let text: String
	public let attributes: [Attribute]?
	public let children: [OPMLEntry]?

	public var title: String? {
		attributes?.first(where: { $0.name == "title" })?.value
	}

	public var siteURL: URL? {
		URL(string: attributes?.first(where: { $0.name == "htmlUrl" })?.value ?? "")
	}

	public var feedURL: URL? {
		URL(string: attributes?.first(where: { $0.name == "xmlUrl" })?.value ?? "")
	}

	public init(
		text: String,
		attributes: [Attribute]?,
		children: [OPMLEntry]? = nil
	) {
		self.text = text
		self.attributes = attributes
		self.children = children
	}

	public init(
		rss feedURL: URL,
		siteURL: URL?,
		title: String,
		attributes: [Attribute]? = nil
	) {
		text = title
		self.attributes = [
			Attribute(name: "title", value: title),
			Attribute(name: "type", value: "rss"),
			Attribute(name: "xmlUrl", value: feedURL.absoluteString),
			Attribute(name: "htmlUrl", value: siteURL?.absoluteString ?? ""),
		] + (attributes ?? [])
		children = nil
	}
}
