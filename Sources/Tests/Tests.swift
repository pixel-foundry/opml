import XCTest
@testable import OPML

class Tests: XCTestCase {

	func testOPMLParsing() {
		guard let file = Bundle.module.url(forResource: "feedly", withExtension: "opml") else {
			XCTFail("Missing opml file")
			return
		}
	}

}
