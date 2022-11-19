import UIKit

final class MatchesViewController: UIViewController {
    private let viewModel: MatchesViewModelLogic
    
    init(viewModel: MatchesViewModelLogic) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
