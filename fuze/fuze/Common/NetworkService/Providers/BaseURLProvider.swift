import Foundation

protocol BaseURLProviderLogic {
    func getURL(api: ApiProvider) -> URL
}

struct BaseURLProvider: BaseURLProviderLogic {
    func getURL(api: ApiProvider) -> URL {
        switch api {
        case .pandaScore:
            guard
                let string = Bundle.main.object(forInfoDictionaryKey: "PANDA_SCORE_BASE_URL") as? String,
                let url = URL(string: string)
            else {
                fatalError("INVALID PANDA SCORE BASE URL")
            }
            
            return url
        }
    }
}
