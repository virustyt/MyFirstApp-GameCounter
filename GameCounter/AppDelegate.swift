//
//  AppDelegate.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 26.08.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13, *) {
            return true
        } else {
            let window = UIWindow.init(frame: UIScreen.main.bounds)
            window.rootViewController = UINavigationController(rootViewController: NewGameViewController())
            window.makeKeyAndVisible()
            
            let decoder = JSONDecoder()
            guard let urlForData = FileManager.urlForGameModel,
                  let data = try? Data(contentsOf: urlForData),
                  let lastSavedGameModel = try? decoder.decode(GameModel.self, from: data) else {return true}
            GameModel.shared = lastSavedGameModel
            return true
        }
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        guard let navigationController = application.keyWindow?.rootViewController as? UINavigationController,
              let gameProcessController = navigationController.children.first(where: {$0 as? GameProcessViewController != nil}) as? GameProcessViewController else {return}
        let encoder = JSONEncoder()
        let data = try? encoder.encode(GameModel.shared)
        try? data?.write(to: FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true))
    }
    
    
}

