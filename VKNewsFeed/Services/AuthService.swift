//
//  AuthService.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 06.07.2021.
//  Copyright © 2021 Виктор Попов. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: AnyObject {
    func autherviceShouldShow(_ xviewController: UIViewController)
    func autherviceSingIn()
    func autherviceSingIdDidFail()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "7896782"
    private let vkSdk: VKSdk
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
        print("VKSdk.initialize")
    }
    
    weak var delegate: AuthServiceDelegate?
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    var userId: String? {
        return VKSdk.accessToken()?.userId
    }
    
    func wakeUpSession() {
        let scope = ["offline","wall","friends"]
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            switch state {
            case .authorized:
                delegate?.autherviceSingIn()
                print("autorized")
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)
                
            default:
                delegate?.autherviceSingIdDidFail()
                fatalError(error!.localizedDescription)
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.autherviceSingIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.autherviceSingIdDidFail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.autherviceShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
