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
    let isLaunchedBefore = UserDefaults.standard.bool(forKey: "isLaunchedBefore")
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        navigationController = UINavigationController()
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        if isLaunchedBefore {
            navigationController?.pushViewController(WelcomeAgainViewController(), animated: false)
        } else {
            navigationController?.pushViewController(WelcomeViewController(), animated: false)
            UserDefaults.standard.set(true, forKey: "isLaunchedBefore")
        }
    }
}

