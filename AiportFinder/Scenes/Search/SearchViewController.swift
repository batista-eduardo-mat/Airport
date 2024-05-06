//
//  SearchViewController.swift
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

protocol SearchDisplayLogic: AnyObject {
    func displaySomething(viewModel: Search.Data.ViewModel)
    func displayAirports(viewModel: Search.Data.ViewModel)
    func displayError(error: Error)
}

class SearchViewController: UIViewController, SearchDisplayLogic {
  
    
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    
    @IBOutlet var radiusLabel: UILabel!
    @IBOutlet var radiusSlider: UISlider!
    
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
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
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
        
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        self.radiusLabel.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        doSearchAirports()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSearchAirports() {
        // 19.541793759109904, -99.0659460651684
        let lat = "-54.81"
        let lon = "-68.315"
        let radius = "60"
        let request = Search.Data.Request(lat: lat, lon: lon, radius: radius)
        interactor?.doSearchAirports(request: request)
        print("doSearchAirports")
    }
    
    func displaySomething(viewModel: Search.Data.ViewModel) {
        //nameTextField.text = viewModel.name
    }
    
    func displayAirports(viewModel: Search.Data.ViewModel) {
        for airport in viewModel.ariports {
            print(airport.name)
        }
    }
    
    
    func displayError(error: any Error) {
        print(error)
    }
    
}