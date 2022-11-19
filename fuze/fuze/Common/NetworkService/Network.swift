import Foundation

enum NetworkError: Error {
    case failureRequest(error: Error)
    case failureToConvertRequest(error: Error)
    case failureResponse
}

protocol NetworkLogic {
    func request<T: Decodable>(_ networkRequest: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void)
    func loadData(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

final class Network {
    private let session: NetworkProviderLogic
    private let deserialization: NetworkDeserializationLogic
    private let urlProvider: BaseURLProviderLogic
    private let accessTokenProvider: AccessTokenProviderLogic
    private let fileManagerProvdider: FileManagerProviderLogic
    
    init(
        session: NetworkProviderLogic,
        deserialization: NetworkDeserializationLogic,
        urlProvider: BaseURLProviderLogic,
        accessTokenProvider: AccessTokenProviderLogic,
        fileManagerProvdider: FileManagerProviderLogic
    ) {
        self.session = session
        self.deserialization = deserialization
        self.urlProvider = urlProvider
        self.accessTokenProvider = accessTokenProvider
        self.fileManagerProvdider = fileManagerProvdider
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
    
    private func download(url: URL, file: URL, completion: @escaping (Error?) -> Void) {
        let task =  session.downloadTask(url: url) { [weak self] dataURL, _, error in
            guard let self = self else { return }
            if let error = error {
                completion(error)
                return
            }

            do {
                if self.fileManagerProvdider.fileExists(path: file.path) {
                    try self.fileManagerProvdider.removeItem(url: file)
                }

                if let dataURL = dataURL {
                    try self.fileManagerProvdider.copyItem(srcURL: dataURL, dstURL: file)
                }
                
                completion(nil)
            } catch {
                completion(error)
            }
        }

        task?.resume()
    }
}

extension Network: NetworkLogic {
    func request<T>(_ networkRequest: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        do {
            let accessToken = accessTokenProvider.getAccessToken(api: networkRequest.baseURL)
            var request = try networkRequest.toRequest(baseURL: urlProvider.getURL(api: networkRequest.baseURL))
            
            request.setValue(accessToken.value, forHTTPHeaderField: accessToken.key)
            
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
    
    func loadData(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let cachedFile = fileManagerProvdider.appendingPathComponent(url.lastPathComponent, isDirectory: false)

        do {
            let data = try Data(contentsOf: cachedFile)
            completion(.success(data))
        } catch {
            download(url: url, file: cachedFile) { error in
                do {
                    let data = try Data(contentsOf: cachedFile)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}
