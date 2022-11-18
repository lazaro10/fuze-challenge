import Foundation

struct AccessTokenProvider {
    static let shared: AccessTokenProvider = AccessTokenProvider()

    var pandaScore: String {
        guard
            let token = Bundle.main.object(forInfoDictionaryKey: "PANDA_SCORE_ACCESS_TOKEN") as? String
        else {
            fatalError("INVALID PANDA SCORE ACESS TOKEN")
        }
        
        return token
    }
}
