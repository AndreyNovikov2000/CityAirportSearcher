//
//  SceneDelegate.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 12/31/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
    }
}
