@testable import fuze
import Foundation

extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }    
}
