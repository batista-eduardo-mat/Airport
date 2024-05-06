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

protocol NetworkManagerProtocol {
    func fetchAirports(with request: Search.Data.Request, completionHandler: @escaping (Result<[Search.Data.Response]>) -> Void )
}

class NetworkManager: NetworkManagerProtocol {
    
    private let airportURL = "https://aviation-reference-data.p.rapidapi.com/airports/search?"
    
    
    func fetchAirports(with request: Search.Data.Request, completionHandler: @escaping (Result<[Search.Data.Response]>) -> Void) {
        
        let headers = [
            "X-RapidAPI-Key": "adcb9d2d3dmsh92bbf2d4f055f97p112887jsnef4d128a7308",
            "X-RapidAPI-Host": "aviation-reference-data.p.rapidapi.com"
        ]
        
        let urlString = "\(airportURL)lat=\(request.lat)&lon=\(request.lon)&radius=\(request.radius)"
        let newRequest = NSMutableURLRequest(url: NSURL(string: urlString)! as URL,cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
        newRequest.httpMethod = "GET"
        newRequest.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: newRequest as URLRequest, completionHandler: { (data, response, error)  in
            if let error = error {
                
                completionHandler(.failure(error))
                
                return
            }
            guard let safedata = data else {
                
                let error = NSError(domain: "SafeDataError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No safe Data"])
                completionHandler(.failure(error))
                
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decodeData = try decoder.decode([Search.Data.Response].self, from: safedata)
                completionHandler(.success(decodeData))
            } catch {
                completionHandler(.failure(error))
            }
            
        })
        
        dataTask.resume()
    }
}
