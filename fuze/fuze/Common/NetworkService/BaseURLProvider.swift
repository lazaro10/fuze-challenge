import Foundation

struct BaseURLProvider {
    static let shared: BaseURLProvider = BaseURLProvider()

    var pandaScore: URL {
        guard
            let string = Bundle.main.object(forInfoDictionaryKey: "PANDA_SCORE_BASE_URL") as? String,
            let url = URL(string: string)
        else {
            fatalError("INVALID PANDA SCORE BASE URL")
        }
        
        return url
    }
}
