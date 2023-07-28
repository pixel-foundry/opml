import XCTest
@testable import OPML

extension Bundle {
    static func locateFirst(forResource: String, withExtension: String) -> URL? {
        for b in Bundle.allBundles {
            if let u = b.url(forResource: forResource, withExtension: withExtension) {
                return u
            }
        }
        return nil
    }
}

class Tests: XCTestCase {

	func testOPMLNested() {
        guard let file = Bundle.module.url(forResource: "rsparser", withExtension: "opml") else {
			XCTFail("Missing opml file")
			return
		}

		do {
			let parser = try OPMLParser(file: file)
			let opml = try parser.parse()
			XCTAssertEqual(opml.entries.flatMap { $0.children ?? [] }.count, 138)
            XCTAssertEqual(opml.entries.count, 73)
            

			let programmingEntries = opml.entries.first(where: { $0.text == "Programming" })?.children
			XCTAssertEqual(programmingEntries?.count ?? 0, 33)
		} catch {
			XCTFail(error.localizedDescription)
		}

	}

	func testOPML2() {
		guard let file = Bundle.module.url(forResource: "feedly", withExtension: "opml") else {
			XCTFail("Missing opml file")
			return
		}

		do {
			let parser = try OPMLParser(file: file)
			let opml = try parser.parse()
			XCTAssertEqual(opml.entries.count, 39)
		} catch {
			XCTFail(error.localizedDescription)
		}
	}

	func testMissingFile() {
		XCTAssertThrowsError(try OPMLParser(file: URL(string: "file:///Resources/nonExistentFile.opml")!).parse())
	}

}
