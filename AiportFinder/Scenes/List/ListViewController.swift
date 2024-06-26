//
//  ListViewController.swift
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

protocol ListDisplayLogic: AnyObject {
    func displaySomething(viewModel: List.Something.ViewModel)
}

class ListViewController: UIViewController, ListDisplayLogic {
    var interactor: ListBusinessLogic?
    var router: (NSObjectProtocol & ListRoutingLogic & ListDataPassing)?
    
    @IBOutlet var airportTableView: UITableView!
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ListInteractor()
        let presenter = ListPresenter()
        let router = ListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        airportTableView.dataSource = self
        //doSomething()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething() {
        let request = List.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: List.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Airports finder"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let airport = router?.dataStore?.airports {
            return airport.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var confing = cell.defaultContentConfiguration()
        if let airports = router?.dataStore?.airports {
            confing.text = airports[indexPath.row].name
            confing.secondaryText = airports[indexPath.row].code
            cell.contentConfiguration = confing
        }
        return cell
    }
}
