import Foundation

final class OPMLBuilder {

	var version: String?
	var title: String?
	var dateCreated: Date?
	var dateModified: Date?
	var ownerName: String?
	var ownerEmail: String?
	var ownerID: URL?
	var docs: URL?
	var entries: [OPMLEntry]?

	func addEntry(_ entry: OPMLEntryBuilder) {
		guard let entry = entry.entry else { return }
		if entries == nil {
			entries = []
		}
		entries?.append(entry)
	}

	func opml() throws -> OPML {
		guard let version = version else { throw Error.missingVersion }
		return OPML(
			version: version,
			title: title,
			dateCreated: dateCreated,
			dateModified: dateModified,
			ownerName: ownerName,
			ownerEmail: ownerEmail,
			ownerID: ownerID,
			docs: docs,
			entries: entries ?? []
		)
	}

	public enum Error: String, LocalizedError {
		public var errorDescription: String? {
			rawValue
		}

		case missingVersion = "Missing OPML version attribute"
	}

}
