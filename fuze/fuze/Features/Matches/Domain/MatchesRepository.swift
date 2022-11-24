protocol MatchesRepositable {
    func fetchRunningMatches(page: Int, completion: @escaping (Result<[MatchModel], Error>) -> Void)
    func fetchUpcomingMatches(page: Int, completion: @escaping (Result<[MatchModel], Error>) -> Void)
}

final class MatchesRepository: MatchesRepositable {
    let network: NetworkRequestable

    init(network: NetworkRequestable) {
        self.network = network
    }

    func fetchRunningMatches(page: Int, completion: @escaping (Result<[MatchModel], Error>) -> Void) {
        let request = MatchesNetworkRequest.running(page: page, configuration: AppConfigurationProvider())

        network.request(request, completion: completion)
    }

    func fetchUpcomingMatches(page: Int, completion: @escaping (Result<[MatchModel], Error>) -> Void) {
        let request = MatchesNetworkRequest.upcoming(page: page, configuration: AppConfigurationProvider())

        network.request(request, completion: completion)
    }
}
