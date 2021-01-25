//
//  UIViewContoller + extention.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/16/21.
//

import UIKit

protocol Storybordable {
    static func initional(stryboardName: String) -> Self
}

extension Storybordable where Self: UIViewController {
    static func initional(stryboardName: String = "Main") -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[0]
        let storyboard = UIStoryboard(name: stryboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: className)
    }
}


extension UIViewController {
    static func loadFromStoryboard<T: UIViewController>(storyboardName: String = "Main") -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(identifier: String(describing: T.self)) as? T else {
            fatalError("Not found storyboard with storyboardName: \(storyboard) or UIViewController should have identifire: \(T.self)")
        }
    
        return viewController
    }
}
