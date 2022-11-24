import UIKit

extension UIFont {
    class func robotoMeidum(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Roboto-Medium", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        
        return font
    }

    class func robotoRegular(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Roboto-Regular", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }

        return font
    }

    class func robotoBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Roboto-Bold", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }

        return font
    }
}
