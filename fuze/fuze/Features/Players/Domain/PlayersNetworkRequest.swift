struct PlayersNetworkRequest: NetworkRequest {
    private let page: Int
    private let teamId: Int

    init(page: Int, teamId: Int) {
        self.page = page
        self.teamId = teamId
    }

    var parameters: [String: String] {
        ["page": "\(page)", "per_page": "20", "filter[team_id]": "\(teamId)"]
    }

    var path: String {
        return "/csgo/players"
    }

    var method: NetworkServiceMethod {
        .get
    }
}
