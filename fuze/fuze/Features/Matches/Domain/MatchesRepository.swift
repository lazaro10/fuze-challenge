protocol MatchesRepositoryLogic {
    func fetchRunningMatches(page: Int, completion: @escaping (Result<[MatchModel], Error>) -> Void)
    func fetchUpcomingMatches(page: Int, completion: @escaping (Result<[MatchModel], Error>) -> Void)
}

final class MatchesRepository: MatchesRepositoryLogic {
    let network: NetworkLogic

    init(network: NetworkLogic) {
        self.network = network
    }

    func fetchRunningMatches(page: Int, completion: @escaping (Result<[MatchModel], Error>) -> Void) {
        let request = MatchesNetworkRequest.running(page: page)

        network.request(request, completion: completion)
    }

    func fetchUpcomingMatches(page: Int, completion: @escaping (Result<[MatchModel], Error>) -> Void) {
        let request = MatchesNetworkRequest.upcoming(page: page)

        network.request(request, completion: completion)
    }
}
