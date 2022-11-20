import UIKit

extension UIImageView {
    func setImage(_ url: URL?, placeholder: UIImage?) {
        image = placeholder

        guard let url = url else { return }

        NetworkDownload.shared.loadData(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            default:
                break
            }
        }
    }
}
