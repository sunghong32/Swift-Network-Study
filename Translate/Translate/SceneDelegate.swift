//
//  SceneDelegate.swift
//  Translate
//
//  Created by 민성홍 on 2022/07/05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.tintColor = .systemPink
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
    }
}

