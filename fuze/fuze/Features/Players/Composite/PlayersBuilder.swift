import Foundation

enum PlayersBuilder {
    static func build(teamId: Int, alignment: PlayersAligment) -> PlayersViewController {
        let viewModel = PlayersViewModel(
            teamId: teamId,
            alignment: alignment,
            repository: PlayersRepository(network: NetworkBuilder.build()),
            converter: PlayersConverter()
        )

        let viewController = PlayersViewController(viewModel: viewModel, contentView: PlayersView())
        viewModel.display = viewController

        return viewController
    }
}
