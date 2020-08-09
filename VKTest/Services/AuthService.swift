//
//  AuthService.swift
//  VKTest
//
//  Created by Anton on 04.08.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import VKSdkFramework

protocol AuthServiceDelegate: AnyObject {
    func authServiceShouldShow(_ viewController: UIViewController)
    func authServiceSignIn()
    func authServiceDidSignInFail()
	func vkSdkUserAuthorizationFailed()
	func vkSdkNeedCaptchaEnter(_ captchaError: VKError!)
}

final class AuthService: NSObject {

    // MARK: - Property list

    private let appId = "7557350"
	private let scope = ["wall, friends"]
    private let vkSdk: VKSdk
    weak var delegate: AuthServiceDelegate?

    var token: String? { return VKSdk.accessToken()?.accessToken }
    
    // MARK: - Initialization
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }

    // MARK: - Internal methods

    func wakeUpSession() {
        VKSdk.wakeUpSession(scope) { state, error in
            switch state {
            case .authorized: self.delegate?.authServiceSignIn()
			case .initialized: VKSdk.authorize(self.scope)
            default: self.delegate?.authServiceDidSignInFail()
            }
        }
    }
}

// MARK: - VKSdkDelegate

extension AuthService: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        guard result.token != nil else { return }
        delegate?.authServiceSignIn()
    }
    
    func vkSdkUserAuthorizationFailed() {
		delegate?.vkSdkUserAuthorizationFailed()
    }
}

// MARK: - VKSdkUIDelegate
extension AuthService: VKSdkUIDelegate {

    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.authServiceShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
		delegate?.vkSdkNeedCaptchaEnter(captchaError)
    }
}
