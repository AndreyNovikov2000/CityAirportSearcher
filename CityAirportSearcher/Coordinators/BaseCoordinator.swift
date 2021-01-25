//
//  BaseCoordinator.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/15/21.
//

import Foundation

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    func start() {
        fatalError("This method should override child classes, method: 'start'")
    }
}
