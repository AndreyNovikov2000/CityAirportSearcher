//
//  AppCoordinator.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/15/21.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    // MARK: - Private propties
    
    private let window: UIWindow
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        let navigationBar = navigationController.navigationBar
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = .systemPink
        navigationBar.tintColor = .white
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 28)!,
                                             NSAttributedString.Key.foregroundColor: UIColor.white]
        return navigationController
    }()

    
    // MARK: - Object livecycle
    
    init?(window: UIWindow?) {
        guard let window = window else { return nil }
        self.window = window
    }
    
    init(window: UIWindow) {
        self.window = window
    }
    
    
    // MARK: - Instance methods
    
    override func start() {
        let searchCityCoordinator = SearchSityCoordinator(navigationController: navigationController)
        add(coordinator: self)
        searchCityCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
