import Foundation

extension String {
    func toMatchDate() -> String {
        guard let date = self.toDateZ() else { return "-" }
        let calendar = Calendar.current

        if calendar.isDateInToday(date) || calendar.isDateInTomorrow(date) {
            return date.toShortDate()
        } else if calendar.isDateInThisWeek(date) {
            return date.toMediumDate()
        } else {
            return date.toLongDate()
        }
    }

    func toDateZ() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        return dateFormatter.date(from: self)
    }
}

extension Date {
    // MARK: Today, 22:00
    func toShortDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true

        return dateFormatter.string(from: self)
    }

    // MARK: Sex, 14:00
    func toMediumDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "E hh:mm"

        return dateFormatter.string(from: self)
    }

    // MARK: 21.11 13:00
    func toLongDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "dd.MM hh:mm"

        return dateFormatter.string(from: self)
    }
}

extension Calendar {
  private var currentDate: Date { return Date() }

  func isDateInThisWeek(_ date: Date) -> Bool {
    return isDate(date, equalTo: currentDate, toGranularity: .weekOfYear)
  }
}
