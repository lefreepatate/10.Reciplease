//
//  AppDelegate.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 05/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
   var window: UIWindow?
//   
//   
//   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//      // Override point for customization after application launch.
//      return true
//   }
//   
//   func applicationWillResignActive(_ application: UIApplication) {
//      
//   }
//   
//   func applicationDidEnterBackground(_ application: UIApplication) {
//      
//   }
//   
//   func applicationWillEnterForeground(_ application: UIApplication) {
//      
//   }
//   
//   func applicationDidBecomeActive(_ application: UIApplication) {
//      
//   }
//   
//   func applicationWillTerminate(_ application: UIApplication) {
//      
//   }
   lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "Reciplease")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
         if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
         }
      })
      return container
   }()
   static var persistentContainer : NSPersistentContainer {
      return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
   }
   static var viewContext: NSManagedObjectContext {
      return persistentContainer.viewContext
   }
}

