enum MatchDetailBuilder {
    static func build(coordinator: MatchesCoordinatorLogic, viewModel: MatchViewModel) -> MatchDetailViewController {
        let viewController = MatchDetailViewController(
            contentView: MatchDetailView(),
            coordinator: coordinator,
            viewModel: viewModel
        )

        return viewController
    }
}
