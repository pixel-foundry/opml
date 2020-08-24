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

	var opml: OPML? {
		guard let version = version else { return nil }
		guard let entries = entries else { return nil }
		return OPML(
			version: version,
			title: title,
			dateCreated: dateCreated,
			dateModified: dateModified,
			ownerName: ownerName,
			ownerEmail: ownerEmail,
			ownerID: ownerID,
			docs: docs,
			entries: entries
		)
	}

}
