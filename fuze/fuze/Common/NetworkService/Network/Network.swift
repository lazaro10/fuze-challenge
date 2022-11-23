import Foundation

enum NetworkError: Error {
    case failureRequest(error: Error)
    case failureToConvertRequest(error: Error)
    case failureResponse
}

protocol NetworkRequestable {
    func request<T: Decodable>(_ networkRequest: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void)
}

final class Network {
    private let session: NetworkProviding
    private let deserialization: NetworkDeserializable
    private let urlProvider: BaseURLProviding
    private let accessTokenProvider: AccessTokenProviding
    
    init(
        session: NetworkProviding,
        deserialization: NetworkDeserializable,
        urlProvider: BaseURLProviding,
        accessTokenProvider: AccessTokenProviding
    ) {
        self.session = session
        self.deserialization = deserialization
        self.urlProvider = urlProvider
        self.accessTokenProvider = accessTokenProvider
    }
    
    private func dataTask(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = session.dataTask(request: request) { (data, response, error) in
            if let error = error {
               return completion(.failure(NetworkError.failureRequest(error: error)))
            }

            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return completion(.failure(NetworkError.failureResponse))
            }
            
            if let data = data {
                return completion(.success(data))
            }
        }
        
        task?.resume()
    }
}

extension Network: NetworkRequestable {
    func request<T>(_ networkRequest: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        do {
            let accessToken = accessTokenProvider.getAccessToken(api: networkRequest.baseURL)
            let request = try networkRequest.toRequest(baseURL: urlProvider.getURL(api: networkRequest.baseURL), token: accessToken)

            dataTask(request: request) { result in
                completion(result.flatMap {
                    do {
                        return try .success(self.deserialization.decode(data: $0))
                    } catch {
                        return .failure(error)
                    }
                })
            }

        } catch {
            completion(.failure(NetworkError.failureToConvertRequest(error: error)))
        }
    }
}
