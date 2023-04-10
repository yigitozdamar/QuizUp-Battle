//
//  SceneDelegate.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 20.01.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import SETabView

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let _ = (scene as? UIWindowScene) else { return }

        if Auth.auth().currentUser?.uid != nil {
            // Show the app's signed-in state.
            let vc = storyboard.instantiateViewController(withIdentifier: "launchVC") as! LaunchViewController
            self.window?.overrideUserInterfaceStyle = .light
            self.window?.rootViewController = vc
        } else {
            let vc = storyboard.instantiateViewController(withIdentifier: "OnboardingVC") as! OnboardingViewController
            self.window?.overrideUserInterfaceStyle = .light
            self.window?.rootViewController = vc
        }

        
       
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

