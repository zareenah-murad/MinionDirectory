//
//  AppDelegate.swift
//  MinionDirectory
//
//  Created by Zareenah Murad on 9/18/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set default difficulty if not already set
        if UserDefaults.standard.string(forKey: "SelectedDifficulty") == nil {
            UserDefaults.standard.set("Beginner", forKey: "SelectedDifficulty")
            print("First launch - Default difficulty set to Beginner")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Handle discarded scenes
    }


    // MARK: - Background and Termination Handling
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Clear UserDefaults when the app goes to the background (if required)
        UserDefaults.standard.removeObject(forKey: "SelectedDifficulty")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Clear UserDefaults when the app is about to terminate
        UserDefaults.standard.removeObject(forKey: "SelectedDifficulty")
    }

    // MARK: - Dark Mode Handling
    func applyDarkMode(isDark: Bool) {
        // Save the state to UserDefaults
        UserDefaults.standard.set(isDark, forKey: "isDarkModeEnabled")

        // Apply dark or light mode to all visible view controllers
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            for window in windowScene.windows {
                if let rootViewController = window.rootViewController {
                    for viewController in rootViewController.children {
                        viewController.view.backgroundColor = isDark ? .darkGray : .white
                    }
                }
            }
        }
    }
}
