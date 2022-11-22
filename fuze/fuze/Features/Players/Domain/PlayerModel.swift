import Foundation

struct PlayerModel: Decodable {
    let imageUrl: URL?
    let nickname: String
    private let firstName: String
    private let lastName: String

    var fullName: String {
        firstName + lastName
    }

    private enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case nickname = "name"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
