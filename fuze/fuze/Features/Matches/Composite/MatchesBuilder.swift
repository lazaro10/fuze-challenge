enum MatchesBuilder {
    static func build(coordinator: MatchesCoordinatorLogic) -> MatchesViewController {
        let viewModel = MatchesViewModel(repository: MatchesRepository(network: NetworkBuilder.build()), converter: MatchesConverter())
        let viewController = MatchesViewController(viewModel: viewModel, contentView: MatchesView(), coordinator: coordinator)
        viewController.title = Strings.matches
        viewModel.display = viewController

        return viewController
    }
}
