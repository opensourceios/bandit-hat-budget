//
//  AppDelegate.swift
//  Budget
//
//  Created by Daniel Gauthier on 2016-11-24.
//  Copyright © 2016 Bandit Hat Apps. All rights reserved.
//

import UIKit
import BudgetKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var containerViewController: ContainerViewController!
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    BuddyBuildSDK.setup()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    containerViewController = ContainerViewController.sharedInstance
    window!.rootViewController = containerViewController
    window!.makeKeyAndVisible()
    
    DispatchQueue.main.async {
      if !BKGroup.signedIn() {
        self.containerViewController.presentHouseholdLaunchView()
      } else if !Settings.hasClaimedUser() {
        self.containerViewController.presentUserClaimView()
      } else {
        self.containerViewController.presentExpenseEntryView()
      }
    }
    
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    BKSharedDataController.saveContext()
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // May want to think a bit harder about exactly when we want to update recent expenses.
    BKSharedBasicRequestClient.getUsers { (success, userArray) in
      BKSharedBasicRequestClient.getCategories { (success, categoryArray) in
        BKSharedBasicRequestClient.getAllRecentExpenses { (success, expenseArray) in
          Utilities.updateDataViews()
        }
      }
    }
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    BKSharedDataController.saveContext()
  }
}

