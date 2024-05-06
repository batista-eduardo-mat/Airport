//
//  SearchWorker.swift
//  AiportFinder
//
//  Created by Eduardo Batista on 04/05/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class SearchWorker {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func doSearchAirportsWork(with request: Search.Data.Request, completionHandler: @escaping (Result<[Search.Data.Response]>) -> Void) {
        networkManager.fetchAirports(with: request, completionHandler: completionHandler)
    }
    
    func doSomeWork() {
        
    }
}
