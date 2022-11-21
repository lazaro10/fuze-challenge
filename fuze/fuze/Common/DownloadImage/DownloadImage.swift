import UIKit

extension UIImageView {
    func setImage(_ url: URL?, placeholder: UIImage?) {
        guard let url = url else {
            image = placeholder
            return
        }

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
