protocol PlayersRepositable {
    func fetchPlayers(page: Int, teamId: Int, completion: @escaping (Result<[PlayerModel], Error>) -> Void)
}

final class PlayersRepository: PlayersRepositable {
    let network: NetworkRequestable

    init(network: NetworkRequestable) {
        self.network = network
    }

    func fetchPlayers(page: Int, teamId: Int, completion: @escaping (Result<[PlayerModel], Error>) -> Void) {
        let request = PlayersNetworkRequest(page: page, teamId: teamId, configuration: AppConfigurationProvider())

        network.request(request, completion: completion)
    }
}
