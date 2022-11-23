@testable import fuze
import Foundation

final class PlayersConverterSpy: PlayersConverterLogic {
    private(set) var invokedConvertCount = 0
    private(set) var invokedConvertParameterPlayers: [PlayerModel]?
    private(set) var invokedConvertParameterAligment: PlayersAligment?
    private(set) var stubbedConvertResult: [PlayerViewModel] = []

    func convert(_ players: [PlayerModel], alignment: PlayersAligment) -> [PlayerViewModel] {
        invokedConvertCount += 1
        invokedConvertParameterPlayers = players
        invokedConvertParameterAligment = alignment
        return stubbedConvertResult
    }
}
