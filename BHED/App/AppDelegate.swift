//
//  AppDelegate.swift
//  BHED
//
//  Created by Joel Youngblood on 5/23/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import UIKit
import RealmSwift
import RxRealm

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Uncomment this line to print the current Realm's file location - handy if you have a Realm browser and need to debug some data...
        //Normally, I'd put the realm file in it's own folder in the Library, but I figured for this project the default is fine
//        debugPrint(Realm.Configuration.defaultConfiguration.fileURL?.absoluteString)
        UINavigationBar.appearance().backgroundColor = .babylonTeal
        UINavigationBar.appearance().tintColor = .babylonPink
        UINavigationBar.appearance().titleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 17),
            .foregroundColor: UIColor.babylonPink
        ]

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: PostsViewController())
        window?.makeKeyAndVisible()
        
        return true
    }
}

