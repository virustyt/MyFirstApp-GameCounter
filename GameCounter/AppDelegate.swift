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
            window.makeKeyAndVisible()
            
            guard let urlForData = FileManager.urlForGameModel else {return true}
            let decoder = JSONDecoder()
            guard let data = try? Data(contentsOf: urlForData),
                  let lastSavedGameModel = try? decoder.decode(GameModel.self, from: data)
            else {
                window.rootViewController = UINavigationController(rootViewController: NewGameViewController())
                GameModel.shared.gameIsGoingOn = false
                return true
            }
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
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        //if GameProcessVC was las vc that user have on screen than save game stats, else delete all such savings
        guard let navigationController = application.keyWindow?.rootViewController as? UINavigationController,
              let appWasInGameSession = navigationController.topViewController?.isKind(of: GameProcessViewController.self),
              appWasInGameSession == true
        else {
            //deleteing file with savings of last game stats
            guard let urlForData = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("GameModel").appendingPathExtension(".json") else {return}
            try? FileManager.default.removeItem(at: urlForData)
            return
        }
        //wiiting file with stats of last game for storing
        let encoder = JSONEncoder()
        let data = try? encoder.encode(GameModel.shared)
        guard let urlForData = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("GameModel").appendingPathExtension(".json") else {return}
        try? data?.write(to: urlForData, options: .atomic)
    }
}

