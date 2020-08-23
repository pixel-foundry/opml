import Foundation

public struct OPMLEntry: Codable, Hashable {

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

}
