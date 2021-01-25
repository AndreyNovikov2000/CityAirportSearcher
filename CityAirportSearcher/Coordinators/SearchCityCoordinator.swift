//
//  SearchCityCoordinator.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/16/21.
//

import UIKit
import RxSwift


class SearchSityCoordinator: BaseCoordinator {
    private var navigationController: UINavigationController
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {        
        let searchViewController: SearchCityViewController = .loadFromStoryboard()
        let airportService = AirportService.shared
        searchViewController.viewModelBuilder = { [disposeBag]  in
            let viewModel = SearchCityViewModel(input: $0, airportService: airportService)
            viewModel
                .routing
                .routing
                .map({ [weak self] welcomeElement in
                    guard let self = self else { return }
                    self.showAirports(usingModel: welcomeElement)
                })
                .drive()
                .disposed(by: disposeBag)
            
            return viewModel
        }
        
        navigationController.pushViewController(searchViewController, animated: true)
    }
}

extension SearchSityCoordinator {
    private func showAirports(usingModel: WelcomeElement) {
        let airportCoordinator = AirportCoordinator(navigationController: navigationController, model: usingModel)
        add(coordinator: self)
        airportCoordinator.start()
    }
}
