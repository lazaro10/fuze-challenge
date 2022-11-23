@testable import fuze
import Foundation

final class MatchesRepositorySpy: MatchesRepositable {
    private(set) var invokedFetchRunningMatchesCount = 0
    private(set) var invokedFetchRunningMatchesParameterPage: Int?
    var stubbedFetchRunningMatchesCompletionResult: Result<[MatchModel], Error>?

    func fetchRunningMatches(page: Int, completion: @escaping (Result<[MatchModel], Error>) -> Void) {
        invokedFetchRunningMatchesCount += 1
        invokedFetchRunningMatchesParameterPage = page
        if let result = stubbedFetchRunningMatchesCompletionResult {
            completion(result)
        }
    }

    private(set) var invokedFetchUpcomingMatchesCount = 0
    private(set) var invokedFetchUpcomingMatchesParameterPage: Int?
    var stubbedFetchUpcomingMatchesCompletionResult: Result<[MatchModel], Error>?

    func fetchUpcomingMatches(page: Int, completion: @escaping (Result<[MatchModel], Error>) -> Void) {
        invokedFetchUpcomingMatchesCount += 1
        invokedFetchUpcomingMatchesParameterPage = page
        if let result = stubbedFetchUpcomingMatchesCompletionResult {
            completion(result)
        }
    }
}
