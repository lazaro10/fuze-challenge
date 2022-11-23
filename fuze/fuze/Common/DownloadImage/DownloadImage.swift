import UIKit

final class DownloadImage {
    unowned private let imageView: UIImageView
    private let networkDownload: NetworkDownloadLogic

    fileprivate init(imageView: UIImageView, networkDownload: NetworkDownloadLogic) {
        self.imageView = imageView
        self.networkDownload = networkDownload
    }

    fileprivate convenience init(imageView: UIImageView) {
        self.init(imageView: imageView, networkDownload: NetworkDownloadBuilder.build())
    }

    func setImage(_ url: URL?, placeholder: UIImage?) {
        guard let url = url else {
            imageView.image = placeholder
            return
        }

        networkDownload.loadData(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                if !Thread.isMainThread {
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(data: data)
                    }
                } else {
                    self?.imageView.image = UIImage(data: data)
                }
            case .failure:
                break
            }
        }
    }
}

extension UIImageView {
    var donwload: DownloadImage {
        DownloadImage(imageView: self)
    }
}
