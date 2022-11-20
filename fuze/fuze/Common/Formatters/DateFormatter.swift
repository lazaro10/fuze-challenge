import Foundation

extension Date {
    func toMatchDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd, hh:mm"

        return dateFormatter.string(from: self)
    }
}

extension String {
    func toDateZ() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        return dateFormatter.date(from: self)
    }
}
