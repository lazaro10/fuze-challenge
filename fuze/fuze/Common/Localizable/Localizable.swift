import Foundation

@propertyWrapper
struct Localizable {
    var wrappedValue: String {
        didSet {
            wrappedValue = NSLocalizedString(wrappedValue, comment: "")
        }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = NSLocalizedString(wrappedValue, comment: "")
    }
}

enum Strings {
    @Localizable static var matches = "matches"
    @Localizable static var now = "now"
}
