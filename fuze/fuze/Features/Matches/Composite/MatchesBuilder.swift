enum MatchesBuilder {
    static func build(coordinator: MatchesCoordinatorLogic) -> MatchesViewController {
        let viewModel = MatchesViewModel(repository: MatchesRepository(network: NetworkBuilder.build()), converter: MatchesConverter())
        let viewController = MatchesViewController(viewModel: viewModel, contentView: MatchesView(), coordinator: coordinator)
        viewModel.display = viewController

        return viewController
    }
}
