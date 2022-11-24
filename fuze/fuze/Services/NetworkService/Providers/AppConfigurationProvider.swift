import Foundation

enum ApiConfiguration {
    case pandaScore
}

protocol AppConfigurationProviding {
    func baseURL(_ configuration: ApiConfiguration) -> URL
    func accessToken(_ configuration: ApiConfiguration) -> String
}

struct AppConfigurationProvider: AppConfigurationProviding {
    func baseURL(_ configuration: ApiConfiguration) -> URL {
        switch configuration {
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

    func accessToken(_ configuration: ApiConfiguration) -> String {
        switch configuration {
        case .pandaScore:
            guard
                let token = Bundle.main.object(forInfoDictionaryKey: "PANDA_SCORE_ACCESS_TOKEN") as? String
            else {
                fatalError("INVALID PANDA SCORE ACESS TOKEN")
            }

            return token
        }
    }
}
