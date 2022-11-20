struct MatchesNetworkRequest: NetworkRequest {
    let page: Int

    var queryParameters: [String: String] {
        ["page": "\(page)", "per_page": "5", "filter[begin_at]": "2022-11-19"]
    }

    var path: String {
        "/csgo/matches"
    }

    var method: NetworkServiceMethod {
        .get
    }
}
