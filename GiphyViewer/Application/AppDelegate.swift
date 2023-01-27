//
//  AppDelegate.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UIBarButtonItem.appearance().tintColor = .white
        let appearance = UINavigationBarAppearance()
        appearance.setBackIndicatorImage(
            UIImage(systemName: "xmark"),
            transitionMaskImage: UIImage(systemName: "xmark")
        )
        appearance.backgroundColor = .black
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = MainScreenAssembly.assemblyModule()
        window.makeKeyAndVisible()
        
        self.window = window
        return true
    }
}

