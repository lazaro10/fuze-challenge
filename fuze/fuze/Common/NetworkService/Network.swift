import Foundation

enum NetworkError: Error {
    case failureRequest(error: Error)
    case failureToConvertRequest(error: Error)
    case failureResponse
}

protocol NetworkLogic {
    func request<T: Decodable>(_ networkRequest: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void)
}

final class Network {
    private let deserialization: NetworkDeserializationLogic
    
    init(deserialization: NetworkDeserializationLogic) {
        self.deserialization = deserialization
    }
}

extension Network: NetworkLogic {
    func request<T>(_ networkRequest: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        do {
            let request = try networkRequest.toRequest(baseURL: networkRequest.baseURL.url)
            let session = URLSession.shared

            let task = session.dataTask(with: request) { [weak self] (data, response, error) in
                guard let self = self else { return }
                if let error = error {
                   return completion(.failure(NetworkError.failureRequest(error: error)))
                }

                guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                    return completion(.failure(NetworkError.failureResponse))
                }
                
                do {
                    let object: T = try self.deserialization.decode(data: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        } catch {
            completion(.failure(NetworkError.failureToConvertRequest(error: error)))
        }
    }
}
