enum MatchesBuilder {
    static func build() -> MatchesViewController {
        let viewModel = MatchesViewModel(repository: MatchesRepository(network: NetworkBuilder.build()))
        let viewController = MatchesViewController(viewModel: viewModel, contentView: MatchesView())
        viewModel.display = viewController

        return viewController
    }
}
