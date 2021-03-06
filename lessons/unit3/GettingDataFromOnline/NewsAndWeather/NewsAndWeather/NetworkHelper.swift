import Foundation

enum NetworkErrors: Error {
    case noDataReceived
}

class NetworkHelper {
    
    let urlSession = URLSession(configuration: .default)
    
    func perform(urlRequest: URLRequest, completion: @escaping ((Data) -> Void), failure: @escaping ((Error) -> Void)) {
        self.urlSession.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    failure(error)
                }
                guard let data = data else {
                    failure(NetworkErrors.noDataReceived)
                    return
                }
                completion(data)
            }
        }.resume()
    }
    
}
