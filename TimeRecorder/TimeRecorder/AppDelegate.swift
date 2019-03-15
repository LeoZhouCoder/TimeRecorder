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
        let settingViewController = SettingViewController()
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

}

