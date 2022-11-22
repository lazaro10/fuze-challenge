import Foundation

struct MatchModel: Decodable {
    let id: Int
    let beginAt: String?
    let opponents: [Opponent]
    let league: League
    let serie: Serie
    let status: Status

    private enum CodingKeys: String, CodingKey {
        case id
        case beginAt = "begin_at"
        case opponents
        case league
        case serie
        case status
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
        let imageUrl: URL?

        private enum CodingKeys: String, CodingKey {
            case name
            case imageUrl = "image_url"
        }
    }

    struct Serie: Decodable {
        let fullName: String

        private enum CodingKeys: String, CodingKey {
            case fullName = "full_name"
        }
    }

    enum Status: String, Decodable {
        case finished
        case notPayed = "not_played"
        case notStarted = "not_started"
        case running
        case canceled
    }
}
