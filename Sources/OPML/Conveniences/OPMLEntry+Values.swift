import Foundation

public extension OPMLEntry {
    func attributeBoolValue(_ name: String) -> Bool? {
        guard let value = attributes?.first(where: { $0.name == name })?.value else { return nil }
        return value == "true"
    }
    
    func attributeStringValue(_ name: String) -> String? {
        return attributes?.first(where: { $0.name == name })?.value
    }
    
    func attributeUUIDValue(_ name: String) -> UUID? {
        guard let value = attributes?.first(where: { $0.name == name })?.value else { return nil }
        return UUID(uuidString: value)
    }
}
