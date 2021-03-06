//
//  AppDelegate.swift
//  MHSlidingMenu
//
//  Created by Masoud Heydari on 3/20/19.
//  Copyright © 2019 smartlife. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupApplication()
        return true
    }
    
    
    private func setupApplication() {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = self.window else { return }
        
        let baseController = PrimaryViewController()
        let menuController = MenuController()
        
        let config = MHSlidingCofig(direction: .RTL, mode: .slideIn, statusbarStyleWhenMenuIsOpen: .default, menuWidth: 310)
        
        
        let rootViewController = MHBaseSlidingController(baseController: baseController, menuController: menuController, config: config)
        window.makeKeyAndVisible()
        window.rootViewController = rootViewController
        window.backgroundColor = .white
    }

}

