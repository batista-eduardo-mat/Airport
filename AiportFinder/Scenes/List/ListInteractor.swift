//
//  ListInteractor.swift
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

protocol ListBusinessLogic {
    func doSomething(request: List.Something.Request)
}

protocol ListDataStore {
    var airports: [Airport] { get set }
}

class ListInteractor: ListBusinessLogic, ListDataStore {
    var airports: [Airport] = []
    
    var presenter: ListPresentationLogic?
    var worker: ListWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: List.Something.Request) {
        worker = ListWorker()
        worker?.doSomeWork()
        
        let response = List.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
