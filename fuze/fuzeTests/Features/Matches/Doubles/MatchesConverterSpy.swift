@testable import fuze
import Foundation

final class MatchesConverterSpy: MatchesConvertable {
    private(set) var invokedConvertMatchModelCount = 0
    private(set) var invokedConvertMatchModelParameterMatchModel: MatchModel?
    var stubbedConvertMatchModelResult: MatchViewModel = .fixture()

    func convert(_ match: MatchModel) -> MatchViewModel {
        invokedConvertMatchModelCount += 1
        invokedConvertMatchModelParameterMatchModel = match
        return stubbedConvertMatchModelResult
    }

    private(set) var invokedConvertCount = 0
    private(set) var invokedConvertParameterMatches: [MatchModel] = []
    var stubbedConvertResult: [MatchViewModel] = []

    func convert(_ matches: [MatchModel]) -> [MatchViewModel] {
        invokedConvertCount += 1
        invokedConvertParameterMatches = matches
        return stubbedConvertResult
    }
}
