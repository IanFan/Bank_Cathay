//
//  AppDelegate.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/8.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        readCustomFonts()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate {
    func readCustomFonts() {
        let fontFileNames = ["SFProText-Regular","SFProText-Bold","SFProText-Heavy","SFProText-Medium","SFProText-Semibold"]
        let dic = UIFactory.getCustomFontNames(fontFileNames: fontFileNames)
        
        for fontFileName in dic.keys {
            if let fontScriptName = dic[fontFileName] {
                print("fontFileName: \(fontFileName), fontScriptName: \(fontScriptName)")
            } else {
                print("Error fontFileName: \(fontFileName)")
            }
        }
        
        print("fontFileNames count: \(fontFileNames.count), fontScriptName count: \(dic.keys.count)")
        print()
    }
}
