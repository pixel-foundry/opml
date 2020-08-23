import Foundation

/// OPML an XML-based format that allows exchange of outline-structured information
/// between applications running on different operating systems and environments.
///
/// http://dev.opml.org
public struct OPML: Codable, Hashable {

	/// A version string, of the form, x.y, where x and y are both numeric strings.
	public let version: String
	/// The title of the document.
	public let title: String?
	/// A date-time, indicating when the document was created.
	public let dateCreated: Date?
	/// A date-time, indicating when the document was last modified.
	public let dateModified: Date?
	/// A string, the owner of the document.
	public let ownerName: String?
	/// A string, the email address of the owner of the document.
	public let ownerEmail: String?
	/// The http address of a web page that contains information
	/// that allows a human reader to communicate with the author of the document
	/// via email or other means. It also may be used to identify the author.
	/// No two authors have the same ownerID.
	public let ownerID: URL?
	/// The http address of documentation for the format used in the OPML file.
	/// It’s probably a pointer to this page for people who might
	/// stumble across the file on a web server 25 years from now and wonder what it is.
	public let docs: URL?

	public let entries: [OPMLEntry]

	public init(
		version: String = "2.0",
		title: String? = nil,
		dateCreated: Date? = Date(),
		dateModified: Date? = nil,
		ownerName: String? = nil,
		ownerEmail: String? = nil,
		ownerID: URL? = nil,
		docs: URL? = URL(string: "http://dev.opml.org/spec2.html"),
		entries: [OPMLEntry]
	) {
		self.version = version
		self.title = title
		self.dateCreated = dateCreated
		self.dateModified = dateModified
		self.ownerName = ownerName
		self.ownerEmail = ownerEmail
		self.ownerID = ownerID
		self.docs = docs
		self.entries = entries
	}

}
