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
    private let session: NetworkProviderLogic
    private let deserialization: NetworkDeserializationLogic
    private let urlProvider: BaseURLProviderLogic
    private let accessTokenProvider: AccessTokenProviderLogic
    
    init(
        session: NetworkProviderLogic,
        deserialization: NetworkDeserializationLogic,
        urlProvider: BaseURLProviderLogic,
        accessTokenProvider: AccessTokenProviderLogic
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

extension Network: NetworkLogic {
    func request<T>(_ networkRequest: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        do {
            let accessToken = accessTokenProvider.getAccessToken(api: networkRequest.baseURL)
            let request = try networkRequest.toRequest(baseURL: urlProvider.getURL(api: networkRequest.baseURL), token: accessToken)

            dataTask(request: request) { result in
                switch result {
                case .success(let data):
                    do {
                        let object: T = try self.deserialization.decode(data: data)
                        completion(.success(object))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(NetworkError.failureToConvertRequest(error: error)))
        }
    }
}
