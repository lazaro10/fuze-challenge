enum MatchDetailBuilder {
    static func build(coordinator: MatchesCoordinatorLogic, viewModel: MatchViewModel) -> MatchDetailViewController {
        let viewController = MatchDetailViewController(
            contentView: MatchDetailView(),
            viewModel: viewModel
        )

        return viewController
    }
}
