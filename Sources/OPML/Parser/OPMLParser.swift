import Foundation
#if canImport(FoundationXML)
import FoundationXML
#endif

final class OPMLParser: NSObject {

	private let xmlParser: XMLParser

	fileprivate var currentXMLDOMPath = URL(string: "/")!

	fileprivate var currentOPMLEntry: OPMLEntryBuilder?

	fileprivate let opmlBuilder = OPMLBuilder()

	func parse() -> OPML? {
		xmlParser.delegate = self
		_ = xmlParser.parse()
		return opmlBuilder.opml
	}

	init(_ data: Data) {
		xmlParser = XMLParser(data: data)
		super.init()
	}

	init?(file url: URL) {
		guard let xmlParser = XMLParser(contentsOf: url) else { return nil }
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
		if var parentEntry = currentOPMLEntry {
			if parentEntry.children == nil {
				parentEntry.children = [entry]
			} else {
				parentEntry.children?.append(entry)
			}
		} else {
			currentOPMLEntry = entry
		}
	}

}
