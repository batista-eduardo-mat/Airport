//
//  ListPresenter.swift
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

protocol ListPresentationLogic {
    func presentSomething(response: List.Something.Response)
}

class ListPresenter: ListPresentationLogic {
    weak var viewController: ListDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: List.Something.Response) {
        let viewModel = List.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
