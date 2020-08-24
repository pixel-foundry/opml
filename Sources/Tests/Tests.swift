import XCTest
@testable import OPML

class Tests: XCTestCase {

	func testOPML2() {
		guard let file = Bundle.module.url(forResource: "feedly", withExtension: "opml") else {
			XCTFail("Missing opml file")
			return
		}

		let parser = OPMLParser(file: file)
		XCTAssertNotNil(parser, "Unable to create XMLParser using \(file)")

		let opml = parser?.parse()
		XCTAssertNotNil(opml, "Unable to parse OPML file")

		XCTAssertEqual(opml?.entries.count ?? 0, 39)
	}

}
