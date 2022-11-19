enum MatchesBuilder {
    static func build() -> MatchesViewController {
        let viewModel = MatchesViewModel()
        let viewController = MatchesViewController(viewModel: viewModel)
        
        return viewController
    }
}
