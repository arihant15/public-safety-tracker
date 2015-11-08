//
//  AppDelegate.swift
//  PublicSafety
//
//  Created by Itua Ijagbone on 11/7/15.
//  Copyright © 2015 Itua Ijagbone. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        NMAApplicationContext.setAppId("DgdDVHCM0LXo256VG0Tz", appCode: "dWE_riW3bMkoF2s5c4sdEw", licenseKey: "QUA1PeeNrvDoQNKd0UWCVL3Smgw44PtpBtm4VsiY3NG1NHPcEGJZttf+UvzGicjLGlJC9UUEPYIRd7RnIcLUvF8rlHGw4D2ZtFao4/JS0XD3ovjkpROEyiqGTTTJJAOEMIjzK105GApAEiwoBFYGSss1usbiu3NrnsjjTdCqcGLD/zXXR9eXKiAfIVBVTRGfwlX2bnIfdHJ25tnoygvRb9W7Dh/Jh4p7ea89uBVxRxwIOIqREAlQnQYmlczYSas3+5KDxEtSvtpIQunuAAJKJxKrazG0sod5F0w7X659uyjRJHu2bNH6hFBmjpfWmWlYQ+vu9pt9XwzVtX0dzqsqdmwuHL2YuCW4Ysp5akSjTMFn54XXCAmdlzRmUSn2CoA/Dr1GoYWlLlMuPMxQAxPOEDJBpcexggYX4NDQWH5zy/0AA0r3NLtGF2wW5Qv4hNGNph7AMn+F0dJh26qXuwX7ZeqK+yo5RUFghtGci/AO7M22yGpV45c5L+X5aUedb4AXdcStQwDwh1Q/JbJfSyP5zcx+g3S7kKKw8SubNGdI51ZVBekHAD9SL5u+FCSMH1ERXsqx47rY1Mo5h4Gy2XfWu/n9E4SGKhURT6Zwh4fpuVX4i5ssPv6Y9Bj8etqgCn5SoZ43ZCx5oThxWSOq9eb8wR7Q5bbRELZb+WapprF8PP8=")
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 255.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().barStyle = .Black
        UINavigationBar.appearance().tintColor = UIColor(red: 255.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        
        return true
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
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

