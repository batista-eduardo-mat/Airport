//
//  RadiusPresenter.swift
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

protocol RadiusPresentationLogic {
    func presentSomething(response: Radius.Something.Response)
}

class RadiusPresenter: RadiusPresentationLogic {
    weak var viewController: RadiusDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Radius.Something.Response) {
        let viewModel = Radius.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
