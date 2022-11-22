import Foundation

struct MatchModel: Decodable {
    let id: Int
    let beginAt: String
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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        beginAt = (try? container.decode(String.self, forKey: .beginAt)) ?? ""
        opponents = try container.decode(Array.self, forKey: .opponents)
        league = try container.decode(League.self, forKey: .league)
        serie = try container.decode(Serie.self, forKey: .serie)
        status = try container.decode(Status.self, forKey: .status)
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

            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)

                name = try container.decode(String.self, forKey: .name)
                imageUrl = (try? container.decode(URL.self, forKey: .imageUrl)) ?? nil
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

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            name = try container.decode(String.self, forKey: .name)
            imageUrl = (try? container.decode(URL.self, forKey: .imageUrl)) ?? nil
        }
    }

    struct Serie: Decodable {
        let fullName: String

        private enum CodingKeys: String, CodingKey {
            case fullName = "full_name"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            fullName = try container.decode(String.self, forKey: .fullName)
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
