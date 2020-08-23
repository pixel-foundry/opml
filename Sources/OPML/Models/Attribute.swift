public struct Attribute: Codable, Hashable {

	public let name: String
	public let value: String

	public init(name: String, value: String) {
		self.name = name
		self.value = value
	}

}
