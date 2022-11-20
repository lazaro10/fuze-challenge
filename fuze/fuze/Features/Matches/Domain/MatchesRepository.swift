protocol MatchesRepositoryLogic {
    func fetchRunningMatches(page: Int, completion: @escaping (Result<[MatchesResponse], Error>) -> Void)
    func fetchUpcomingMatches(page: Int, completion: @escaping (Result<[MatchesResponse], Error>) -> Void)
}

final class MatchesRepository: MatchesRepositoryLogic {
    let network: NetworkLogic

    init(network: NetworkLogic) {
        self.network = network
    }

    func fetchRunningMatches(page: Int, completion: @escaping (Result<[MatchesResponse], Error>) -> Void) {
        let request = MatchesNetworkRequest.running(page: page)

        network.request(request) { (result: Result<[MatchesResponse], Error>) in
            completion(result)
        }
    }

    func fetchUpcomingMatches(page: Int, completion: @escaping (Result<[MatchesResponse], Error>) -> Void) {
        let request = MatchesNetworkRequest.upcoming(page: page)

        network.request(request) { (result: Result<[MatchesResponse], Error>) in
            completion(result)
        }
    }
}
