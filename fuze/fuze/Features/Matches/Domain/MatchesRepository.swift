protocol MatchesRepositoryLogic {
    func fetchMatched(page: Int, completion: @escaping (Result<[MatchesResponse], Error>) -> Void)
}

final class MatchesRepository: MatchesRepositoryLogic {
    let network: NetworkLogic

    init(network: NetworkLogic) {
        self.network = network
    }

    func fetchMatched(page: Int, completion: @escaping (Result<[MatchesResponse], Error>) -> Void) {
        let request = MatchesNetworkRequest(page: page)

        network.request(request) { (result: Result<[MatchesResponse], Error>) in
            completion(result)
        }
    }
}
