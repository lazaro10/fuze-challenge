import Foundation

protocol AccessTokenProviderLogic {
    func getAccessToken(api: APINetwork) -> (key: String, value: String)
}

struct AccessTokenProvider: AccessTokenProviderLogic {
    func getAccessToken(api: APINetwork) -> (key: String, value: String) {
        switch api {
        case .pandaScore:
            guard
                let token = Bundle.main.object(forInfoDictionaryKey: "PANDA_SCORE_ACCESS_TOKEN") as? String
            else {
                fatalError("INVALID PANDA SCORE ACESS TOKEN")
            }
            
            return (key: "token", value: token)
        }
    }
}
