protocol MatchDetailConverterLogic {
    func convert(firstTeamPlayers: [PlayerModel], secondTeamPlayers: [PlayerModel]) -> [PlayersViewModel]
}

struct MatchDetailConverter: MatchDetailConverterLogic {
    func convert(firstTeamPlayers: [PlayerModel], secondTeamPlayers: [PlayerModel]) -> [PlayersViewModel] {
        return []
    }
}
