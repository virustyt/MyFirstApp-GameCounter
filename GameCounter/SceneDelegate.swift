//
//  SceneDelegate.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 26.08.2021.
//

import UIKit

@available (iOS 13,*)

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()
        
        guard let urlForData = FileManager.urlForGameModel else {return}
        let decoder = JSONDecoder()
        guard let data = try? Data(contentsOf: urlForData),
              let lastSavedGameModel = try? decoder.decode(GameModel.self, from: data)
        else {
            window?.rootViewController = RootNavigationController(rootViewController: NewGameViewController())
            GameModel.shared.gameIsGoingOn = false
            return
        }
        GameModel.shared = lastSavedGameModel
        window?.rootViewController = RootNavigationController(rootViewController: GameProcessViewController())
    }

    func sceneDidEnterBackground(_ scene: UIScene) {        
        //if GameProcessVC was las vc that user have on screen than save game stats, else delete all such savings
        guard let navigationController = window?.rootViewController as? UINavigationController,
              let appWasInGameSession = navigationController.topViewController?.isKind(of: GameProcessViewController.self),
              appWasInGameSession == true
        else {
            //deleteing file with savings of last game stats
            guard let urlForData = FileManager.urlForGameModel else {return}
            try? FileManager.default.removeItem(at: urlForData)
            return
        }
        
        //wiiting file with stats of last game for storing
        let encoder = JSONEncoder()
        let data = try? encoder.encode(GameModel.shared)
        guard let urlForData = FileManager.urlForGameModel else {return}
        try? data?.write(to: urlForData, options: .atomic)
    }
}

