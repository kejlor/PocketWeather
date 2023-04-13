//
//  AppDelegate.swift
//  PocketWeather
//
//  Created by Bartosz Wojtkowiak on 08/04/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let weatherViewController = WeatherViewController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = weatherViewController
        
        return true
    }
}

var ENV: APIKeyable {
    return ProdENV()
}
