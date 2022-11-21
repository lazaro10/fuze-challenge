import UIKit

extension UIImageView {
    func setImage(_ url: URL?, placeholder: UIImage?) {
        guard let url = url else {
            self.image = placeholder
            return
        }

        DispatchQueue.global().async { [weak self] in
            NetworkDownload.shared.loadData(url: url) { result in
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
}
