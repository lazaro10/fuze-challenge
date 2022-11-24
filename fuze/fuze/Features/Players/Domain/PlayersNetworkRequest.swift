struct PlayersNetworkRequest: NetworkRequest {
    private let page: Int
    private let teamId: Int
    private let configuration: AppConfigurationProviding

    init(page: Int, teamId: Int, configuration: AppConfigurationProviding) {
        self.page = page
        self.teamId = teamId
        self.configuration = configuration
    }

    var parameters: [String: String] {
        [
            "page": "\(page)",
            "per_page": "20",
            "filter[team_id]": "\(teamId)",
            "token": configuration.accessToken(.pandaScore)
        ]
    }

    var path: String {
        return "/csgo/players"
    }

    var method: NetworkServiceMethod {
        .get
    }
}
