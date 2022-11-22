@testable import fuze
import Foundation

final class MatchesConverterSpy: MatchesConverterLogic {
    private(set) var invokedConvertCount = 0
    private(set) var invokedConvertParameterMatches: [MatchModel] = []
    var stubbedConvertResult: [MatchViewModel] = []

    func convert(_ matches: [MatchModel]) -> [MatchViewModel] {
        invokedConvertCount += 1
        invokedConvertParameterMatches = matches
        return stubbedConvertResult
    }
}
