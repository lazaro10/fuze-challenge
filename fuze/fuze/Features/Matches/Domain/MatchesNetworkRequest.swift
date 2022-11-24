enum MatchesNetworkRequest: NetworkRequest {
    case running(page: Int, configuration: AppConfigurationProviding)
    case upcoming(page: Int, configuration: AppConfigurationProviding)

    var parameters: [String: String] {
        switch self {
        case let .running(page, configuration):
            return ["page": "\(page)", "per_page": "10", "token": configuration.accessToken(.pandaScore)]
        case let .upcoming(page, configuration):
            return ["page": "\(page)", "per_page": "10", "token": configuration.accessToken(.pandaScore)]
        }
    }

    var path: String {
        switch self {
        case .running:
            return "/csgo/matches/running"
        case .upcoming:
            return "/csgo/matches/upcoming"
        }
    }

    var method: NetworkServiceMethod {
        .get
    }
}
