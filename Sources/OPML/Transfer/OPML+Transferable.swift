import SwiftUI
import UniformTypeIdentifiers

enum TransferError: Error {
    case importFailed
}

@available(iOS 16.0, macOS 13.0, *)
extension OPML: Transferable {
    public static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .fileURL,
                           shouldAttemptToOpenInPlace: false) { opml in
            let resultURL = FileManager.default.temporaryDirectory
                .appendingPathComponent(opml.title ?? UUID().uuidString)
                .appendingPathExtension("opml")
            if FileManager.default.fileExists(atPath: resultURL.path) {
                try FileManager.default.removeItem(at: resultURL)
            }
            let data = opml.xml.data(using: .utf8) ?? Data()
            try data.write(to: resultURL, options: [.atomic])
            return SentTransferredFile(resultURL, allowAccessingOriginalFile: true)
        } importing: { opmlFile in
            let data = try Data(contentsOf: opmlFile.file, options: [.uncached])
            return (try? OPML(data)) ?? OPML(entries: [])
        }
        
        DataRepresentation(contentType: .opml) { opml in
            opml.xml.data(using: .utf8) ?? Data()
        } importing: { data in
            return (try? OPML(data)) ?? OPML(entries: [])
        }
        
        DataRepresentation(contentType: .utf8PlainText) { opml in
            opml.xml.data(using: .utf8) ?? Data()
        } importing: { data in
            return (try? OPML(data)) ?? OPML(entries: [])
        }
    }
}

extension UTType {
    static let opml = UTType(exportedAs: "public.opml", conformingTo: .xml)
}
