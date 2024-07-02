# NetworkService

This is a simple Swift utility for making network requests and decoding and encoding JSON responses.

## Usage

1. **Importing the Module**:
   ```swift
   import NetworkingService
   ```

2. **Using the NetworkService:**:
   ```swift
struct MyEndPoint: EndPoint {
    var host: String = "api.example.com"
    var path: String = "/data"
    var method: String = "GET"
    var headers: [String : String]? = ["Content-Type": "application/json"]
    var body: Data? = nil
    var queryItems: [URLQueryItem]? = [URLQueryItem(name: "query", value: "example")]
    var pathParams: [String : String]? = nil
}

// Make a request
NetworkService.shared.sendRequest(endpoint: MyEndPoint()) { (result: Result<MyResponseModel, NetworkError>) in
    switch result {
    case .success(let responseModel):
        print("Success: \(responseModel)")
    case .failure(let error):
        print("Error: \(error)")
    }
}
   }
   ```

## Error Handling

The `getData` function returns a `Result` enum containing either the decoded data or an error. In case of an error, it returns a NetworkError. 

   ```swift
   NetworkService.shared.sendRequest(endpoint: MyEndPoint()) { (result: Result<MyResponseModel, NetworkError>) in
    switch result {
    case .success(let responseModel):
        print("Success: \(responseModel)")
    case .failure(let error):
        switch error {
        case .invalidURL:
            print("Invalid URL")
        case .unexpectedStatusCode(let message):
            print("Unexpected Status Code: \(message)")
        case .unknown:
            print("Unknown Error")
        case .decode:
            print("Decode Error")
        }
    }
}
    ```

