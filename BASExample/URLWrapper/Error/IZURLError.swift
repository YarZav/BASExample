public enum IZURLError: Error {
  case unspecified(statusMessage: String)
}

public extension Int {
  func urlError() -> IZURLError {
    switch self {
    default:
      return .unspecified(statusMessage: "Error")
    }
  }
}
