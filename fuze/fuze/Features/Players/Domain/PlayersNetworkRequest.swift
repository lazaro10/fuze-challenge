struct PlayersNetworkRequest: NetworkRequest {
    let page: Int
    let teamId: Int

    var parameters: [String: String] {
        ["page": "\(page)", "per_page": "50", "filter[team_id]": "\(teamId)"]
    }

    var path: String {
        return "/csgo/players"
    }

    var method: NetworkServiceMethod {
        .get
    }
}
