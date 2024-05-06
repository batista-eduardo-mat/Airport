//
//  NetworkManager.swift
//  AiportFinder
//
//  Created by Eduardo Batista on 04/05/24.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum NetworkingError: Error {
    case invalidJSON
    case invalidResponse
    case domainError
    case requestFailed(Error)
    case invalidEncode
}

class NetworkManager {
    let urlString = "https://aviation-reference-data.p.rapidapi.com/airports/search?"
    
    func makeRequest<T: Decodable>(with parameters: [String:String]?, completion: @escaping (Result<T>) -> Void ) {
        let headers = [
            "X-RapidAPI-Key": "adcb9d2d3dmsh92bbf2d4f055f97p112887jsnef4d128a7308",
            "X-RapidAPI-Host": "aviation-reference-data.p.rapidapi.com"
        ]
        
        var body = ""
        
        do {
            let jsonEncoder = JSONEncoder()
            let data = try jsonEncoder.encode(parameters.self)
            body = String(decoding: data, as: UTF8.self)
        } catch {
            completion(.failure(NetworkingError.invalidEncode))
            return
        }
        
        var components = URLComponents(string: urlString)
        if let parameters = parameters {
            components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        
        guard let url = components?.url else {
            DispatchQueue.main.async {
                completion(.failure(NetworkingError.domainError))
            }
            return
        }
        
        let request = NSMutableURLRequest(url: url as URL,cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        request.httpBody = body.data(using: .utf8)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error)  in
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(NetworkingError.requestFailed(error!)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkingError.invalidResponse))
                }
                return
            }
            let decodeResult: Result<T> = self.decodeData(data: data)
            completion(decodeResult)
            
        })
        
        dataTask.resume()
        
        
    }
    
    private func decodeData<T: Decodable>(data: Data?) -> Result<T> {
        guard let validData = data  else { return .failure(NetworkingError.invalidJSON) }
        
        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(T.self, from: validData)
            return .success(decoded)
        } catch {
            return .failure(NetworkingError.invalidJSON)
        }
    }
}
