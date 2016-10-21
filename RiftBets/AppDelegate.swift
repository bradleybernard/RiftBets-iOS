//
//  AppDelegate.swift
//  RiftBets
//
//  Created by Brad Bernard on 10/8/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Fabric.with([Crashlytics.self])
       // KeychainManager.sharedInstance.logout()
     
        chooseFirstController()
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func mainTabbar()
    {
        UIView.transitionWithView(self.window!, duration: 0.5, options: .TransitionCrossDissolve, animations: {
            let oldState: Bool = UIView.areAnimationsEnabled()
            UIView.setAnimationsEnabled(false)
            self.window!.rootViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("InitialViewController") )
            UIView.setAnimationsEnabled(oldState)
            }, completion: { (finished: Bool) -> () in
                
                //Whisper(Message(title: "Login successful!", textColor: UIColor.whiteColor(), backgroundColor: UIColor.greenColor(), images: nil), to: self.window!.rootViewController!.navigationController!)
        })
        
    }
    
    func authNav()
    {
        UIView.transitionWithView(self.window!, duration: 0.5, options: .TransitionCrossDissolve, animations: {
            let oldState: Bool = UIView.areAnimationsEnabled()
            UIView.setAnimationsEnabled(false)
            self.window!.rootViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HomeView") )
            UIView.setAnimationsEnabled(oldState)
            }, completion: { (finished: Bool) -> () in
                
        })
        
    }
    
    func chooseFirstController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
 
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        
        var viewController : UIViewController = storyboard.instantiateViewControllerWithIdentifier("HomeView") as! HomeViewController
        
        if (KeychainManager.sharedInstance.getLoggedIn()) {
            viewController = storyboard.instantiateViewControllerWithIdentifier("InitialViewController") as! TabbedViewController
           
        }
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    
}

