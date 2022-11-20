enum MatchesNetworkRequest: NetworkRequest {
    case running(page: Int)
    case upcoming(page: Int)

    var parameters: [String: String] {
        switch self {
        case .running(let page):
            return ["page": "\(page)", "per_page": "50"]
        case .upcoming(let page):
            return ["page": "\(page)", "per_page": "5"]
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
