//
//  AppDelegate.swift
//  VKTest
//
//  Created by Anton on 03.08.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import UIKit
import VKSdkFramework

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate
{
    // MARK: - Property list

    private let authService = AuthService()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        authService.delegate = self
        window = UIWindow(frame: UIScreen.main.bounds)
        let authVC = AuthVC(authService: authService)
        window?.rootViewController = authVC
        window?.makeKeyAndVisible()

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }
}

// MARK: - AuthServiceDelegate

extension AppDelegate: AuthServiceDelegate
{
    func authServiceShouldShow(_ viewController: UIViewController) {
        let rootVC = window?.rootViewController
        rootVC?.present(viewController, animated: true)
    }
    
    func authServiceSignIn() {
        guard let token = authService.token else { return }
        let networkService = FeedsNetworkService(token: token)
        let feedVC = FeedVC(networkService: networkService)
        let navigationController = LightStatusBarNavigationController(rootViewController: feedVC)
        navigationController.modalPresentationStyle = .fullScreen
		navigationController.modalPresentationCapturesStatusBarAppearance = true
		window?.rootViewController = navigationController
    }
    
    func authServiceDidSignInFail() {
		window?.rootViewController?.showAlert(title: #function)
    }

	func vkSdkUserAuthorizationFailed() {
		window?.rootViewController?.showAlert(title: #function)
	}
	
	func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
		window?.rootViewController?.showAlert(title: #function, message: captchaError.description)
	}
	
}
