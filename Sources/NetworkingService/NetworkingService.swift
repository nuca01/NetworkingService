// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

// MARK: - enum NetworkError
public enum NetworkError: Error {
    case invalidURL
    case unexpectedStatusCode(String = "The status code returned was unexpected.")
    case unknown
    case decode
    case noInternetConnection
}

// MARK: - class NetworkService
public final class NetworkingService {
    public static var shared = NetworkingService()
    
    private init(){}
    
    public func sendRequest<T: Decodable>(endpoint: EndPoint, resultHandler: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let urlRequest = createRequest(endPoint: endpoint) else {
            resultHandler(.failure(.invalidURL))
            return
        }
        
        let urlTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error as? URLError {
                switch error.code {
                case .notConnectedToInternet, .networkConnectionLost:
                    resultHandler(.failure(.noInternetConnection))
                default:
                    resultHandler(.failure(.invalidURL))
                }
                return
            }
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                let errorResponse = String(data: data ?? Data(), encoding: .utf8)
                resultHandler(.failure(.unexpectedStatusCode(errorResponse ?? "An unknown error occurred.")))
                return
            }
            guard let data = data else {
                resultHandler(.failure(.unknown))
                return
            }
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                resultHandler(.failure(.decode))
                return
            }
            resultHandler(.success(decodedResponse))
        }
        urlTask.resume()
    }
    
    // MARK: - private helper method
    private func createRequest(endPoint: EndPoint) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = endPoint.scheme
        urlComponents.host = endPoint.host
        urlComponents.path = endPoint.path
        urlComponents.queryItems = endPoint.queryItems
        guard let url = urlComponents.url else {
            return nil
        }
        let encoder = JSONEncoder()
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method
        request.allHTTPHeaderFields = endPoint.headers
        if let body = endPoint.body {
            request.httpBody = try? encoder.encode(body)
        }
        return request
    }
}
