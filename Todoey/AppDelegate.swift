//
//  AppDelegate.swift
//  Todoey
//
//  Created by Lucas Rocha on 2019-07-24.
//  Copyright © 2019 Lucas Rocha. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        
        do {
            _ = try Realm()

        } catch {
            print("Problem initialising the Realm DB \(error)")
        }
        
        return true
    }
}

