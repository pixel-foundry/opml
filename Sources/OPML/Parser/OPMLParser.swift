import Foundation
#if canImport(FoundationXML)
import FoundationXML
#endif

final class OPMLParser: NSObject {

	private let xmlParser: XMLParser

	fileprivate var currentXMLDOMPath = URL(string: "/")!

	fileprivate var currentOPMLEntry: OPMLEntryBuilder?

	fileprivate let opmlBuilder = OPMLBuilder()

	func parse() throws -> OPML {
		xmlParser.delegate = self
		let success = xmlParser.parse()
		if !success {
			if let error = xmlParser.parserError {
				throw Error.parseError(error)
			} else {
				throw Error.invalidDocument
			}
		}
		return try opmlBuilder.opml()
	}

	init(_ data: Data) {
		xmlParser = XMLParser(data: data)
		super.init()
	}

	init(file url: URL) throws {
		guard let xmlParser = XMLParser(contentsOf: url) else { throw Error.unableToOpenURL(url) }
		self.xmlParser = xmlParser
		super.init()
	}

}

extension OPMLParser: XMLParserDelegate {

	func parser(
		_ parser: XMLParser,
		didStartElement elementName: String,
		namespaceURI: String?,
		qualifiedName qName: String?,
		attributes attributeDict: [String: String] = [:]
	) {
		let currentElement = elementName.lowercased()
		currentXMLDOMPath.appendPathComponent(currentElement)
		guard currentXMLDOMPath.pathComponents.contains("opml") else { return }
		switch currentElement {
		case "opml":
			parseOPMLTag(attributeDict)
		case "outline":
			parseOutlineTag(attributeDict)
		default:
			return
		}
	}

	func parser(
		_ parser: XMLParser,
		didEndElement elementName: String,
		namespaceURI: String?,
		qualifiedName qName: String?
	) {
		currentXMLDOMPath.deleteLastPathComponent()
		switch elementName.lowercased() {
		case "outline":
			guard currentXMLDOMPath.lastPathComponent != "outline",
				  let currentEntry = currentOPMLEntry else { return }
			opmlBuilder.addEntry(currentEntry)
			currentOPMLEntry = nil
		default:
			return
		}
	}

	func parser(_ parser: XMLParser, foundCharacters string: String) {
		switch currentXMLDOMPath.lastPathComponent {
		case "title":
			opmlBuilder.title = string
		default:
			return
		}
	}

	private func parseOPMLTag(_ attributes: [String: String]) {
		opmlBuilder.version = attributes.first(where: { $0.key.lowercased() == "version" })?.value
	}

	private func parseOutlineTag(_ attributes: [String: String]) {
		guard let text = attributes.first(where: { $0.key.lowercased() == "text" })?.value else {
			return
		}
		let entry = OPMLEntryBuilder(text: text, attributes: attributes.map { Attribute(name: $0.key, value: $0.value) })
		if let parentEntry = currentOPMLEntry {
			if parentEntry.children == nil {
				parentEntry.children = [entry]
			} else {
				parentEntry.children?.append(entry)
			}
		} else {
			currentOPMLEntry = entry
		}
	}

	public enum Error: LocalizedError {
		public var errorDescription: String? {
			switch self {
			case .invalidDocument: return "Invalid or missing XML document"
			case .parseError(let error): return "XML parsing error: \(error.localizedDescription)"
			case .unableToOpenURL(let url): return "Unable to open a file at the given URL \(url)"
			}
		}

		case invalidDocument
		case parseError(Swift.Error)
		case unableToOpenURL(URL)
	}

}
