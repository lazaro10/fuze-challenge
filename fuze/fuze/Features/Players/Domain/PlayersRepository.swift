protocol PlayersRepositoryLogic {
    func fetchPlayers(page: Int, teamId: Int, completion: @escaping (Result<[PlayerModel], Error>) -> Void)
}

final class PlayersRepository: PlayersRepositoryLogic {
    let network: NetworkLogic

    init(network: NetworkLogic) {
        self.network = network
    }

    func fetchPlayers(page: Int, teamId: Int, completion: @escaping (Result<[PlayerModel], Error>) -> Void) {
        let request = PlayersNetworkRequest(page: page, teamId: teamId)

        network.request(request, completion: completion)
    }
}
