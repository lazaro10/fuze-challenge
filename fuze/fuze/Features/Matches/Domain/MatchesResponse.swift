import Foundation

struct MatchesResponse: Decodable {
    let beginAt: String
    let opponents: [Opponent]
    let league: League
    let serie: Serie

    private enum CodingKeys: String, CodingKey {
        case beginAt = "begin_at"
        case opponents
        case league
        case serie
    }

    struct Opponent: Decodable {
        let opponent: OpponentData?

        struct OpponentData: Decodable {
            let name: String
            let imageUrl: URL?

            private enum CodingKeys: String, CodingKey {
                case name
                case imageUrl = "image_url"
            }
        }
    }

    struct League: Decodable {
        let name: String
    }

    struct Serie: Decodable {
        let fullName: String

        private enum CodingKeys: String, CodingKey {
            case fullName = "full_name"
        }
    }
}
