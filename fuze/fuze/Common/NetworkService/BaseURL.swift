import Foundation

enum BaseURL {
    case pandaScore
    
    var url: URL {
        switch self {
        case .pandaScore:
            return BaseURLProvider.shared.pandaScore
        }
    }
}
