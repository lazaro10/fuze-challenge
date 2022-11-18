import Foundation

enum BaseURL {
    case pandaScore
    
    var url: URL {
        URL(string: "https://api.pandascore.co")!
    }
}
