//
//  AppDelegate.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/13.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        DatabaseModel.initDatabase()
        
        // create a UIWindow
        self.window = UIWindow(frame:UIScreen.main.bounds)
        self.window!.backgroundColor = UIColor.white
        
        // create UITabBarController
        let tabBar = UITabBarController()
        tabBar.tabBar.backgroundColor = UIColor.clear
        
        // timer
        let timerViewController = TimerViewController()
        timerViewController.tabBarItem = UITabBarItem(
            title: "Timer",
            image: UIImage(named: "TabTimer"),
            tag: 100)
        
        // records
        let recordsViewController = RecordsViewController()
        recordsViewController.tabBarItem = UITabBarItem(
            title: "Records",
            image: UIImage(named: "TabRecords"),
            tag: 200)
        
        // chats
        let chatsViewController = ChatsViewController()
        chatsViewController.tabBarItem = UITabBarItem(
            title: "Chats",
            image: UIImage(named: "TabChats"),
            tag: 300)
        
        // setting
        let settingViewController = SettingViewController(title: "Setting", showTabBar: true)
        settingViewController.tabBarItem = UITabBarItem(
            title: "Setting",
            image: UIImage(named: "TabSetting"),
            tag: 400)
        
        tabBar.viewControllers = [
            UINavigationController(rootViewController: timerViewController),
            UINavigationController(rootViewController: recordsViewController),
            UINavigationController(rootViewController: chatsViewController),
            UINavigationController(rootViewController: settingViewController)]
        
        tabBar.selectedIndex = 0
        
        self.window!.rootViewController = tabBar
        self.window!.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

