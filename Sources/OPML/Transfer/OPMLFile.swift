import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct OPMLFile: FileDocument {
    // tell the system we support only plain text
    public static var readableContentTypes = [UTType(exportedAs: "public.opml"), UTType.plainText]

    public var title = ""
    
    // by default our document is empty
    public var text = ""

    // a simple initializer that creates new, empty documents
    public init(opml: OPML) {
        text = opml.xml
        title = opml.title ?? ""
    }

    // this initializer loads data that has been saved previously
    public init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        }
    }

    // this will be called when the system wants to write our data to disk
    public func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}
