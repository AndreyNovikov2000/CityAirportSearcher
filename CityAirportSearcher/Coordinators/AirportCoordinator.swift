//
//  AirportCoordinator.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/22/21.
//

import UIKit

class AirportCoordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController
    private let model: WelcomeElement
    
    init(navigationController: UINavigationController, model: WelcomeElement) {
        self.navigationController = navigationController
        self.model = model
    }
    
    override func start() {
        let airportViewController: AirportViewController = .loadFromStoryboard()
        airportViewController.viewModelBuilder = { input in
            let viewModel = AirpotsViewModel(input: input, dependecies:  (self.model.title, self.model))
            
            return viewModel
        }
        navigationController.pushViewController(airportViewController, animated: true)
    }
}
