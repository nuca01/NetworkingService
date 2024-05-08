# NetworkService

This is a simple Swift utility for making network requests and decoding JSON responses.

## Usage

1. **Importing the Module**:
   ```swift
   import Foundation
   ```

2. **Creating Network Requests**:
   ```swift
   NetworkService.networkService.getData(urlString: "YOUR_URL_HERE") { (result: Result<YourDecodableType, Error>) in
       switch result {
       case .success(let data):
           // Handle successful response
       case .failure(let error):
           // Handle error
       }
   }
   ```

   Replace `YourDecodableType` with the type you expect to receive from the server.

## Error Handling

The `getData` function returns a `Result` enum containing either the decoded data or an error. In case of an error, it returns a `NetworkError.decodeError` if there's an issue decoding the received data.

## Note

Ensure that your URL is valid and that your server responds with a JSON object compatible with the `YourDecodableType` you specify.
