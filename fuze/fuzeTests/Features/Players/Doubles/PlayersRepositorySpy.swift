@testable import fuze
import Foundation

final class PlayersRepositorySpy: PlayersRepositoryLogic {
    var invokedFetchPlayersCount = 0
    var invokedFetchPlayersParameterPage: Int?
    var invokedFetchPlayersParameterTeamId: Int?
    var stubbedFetchPlayersCompletionResult: Result<[PlayerModel], Error>?

    func fetchPlayers(page: Int, teamId: Int, completion: @escaping (Result<[PlayerModel], Error>) -> Void) {
        invokedFetchPlayersCount += 1
        invokedFetchPlayersParameterPage = page
        invokedFetchPlayersParameterTeamId = teamId
        if let result = stubbedFetchPlayersCompletionResult {
            completion(result)
        }
    }
}
