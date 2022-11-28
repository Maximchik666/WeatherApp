//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 28.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

                navigationController = UINavigationController()
                navigationController?.pushViewController(ViewController(), animated: false)

                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
                self.window = window
    }
}

