enum MatchDetailBuilder {
    static func build(viewModel: MatchViewModel) -> MatchDetailViewController {
        let viewModel = MatchDetailViewModel(matchViewModel: viewModel)
        let viewController = MatchDetailViewController(
            viewModel: viewModel, contentView: MatchDetailView()
        )
        viewModel.display = viewController

        return viewController
    }
}
