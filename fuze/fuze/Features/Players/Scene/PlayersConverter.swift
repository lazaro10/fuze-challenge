protocol PlayersConvertable {
    func convert(_ players: [PlayerModel], alignment: PlayersAligment) -> [PlayerViewModel]
}

struct PlayersConverter: PlayersConvertable {
    func convert(_ players: [PlayerModel], alignment: PlayersAligment) -> [PlayerViewModel] {
        players.map {
            PlayerViewModel(
                imageURL: $0.imageUrl,
                nickname: $0.nickname,
                name: $0.fullName,
                alignment: alignment
            )
        }
    }
}
