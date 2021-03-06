//
//  VkSignInHandler.swift
//  VK-API-Test-Project
//
//  Created by Yurii Chukhlib on 26.03.17.
//  Copyright © 2017 Yuri Chukhlib. All rights reserved.
//

import UIKit
import SwiftyVK

typealias VKSignInCompletion = (_ error: AuthError?) -> ()

protocol VkSigningProtocol {
	func signIn(signInCompletion: @escaping VKSignInCompletion)
}

fileprivate let appID = "5947003"

class VkSignInHandler: VKDelegate, VkSigningProtocol {
	
	fileprivate var signInCompletion: VKSignInCompletion?
	fileprivate let scope: Set<VK.Scope> = [.photos]
	
	init() {
		VK.configure(withAppId: appID, delegate: self)
	}
	
	func signIn(signInCompletion: @escaping VKSignInCompletion) {
		VK.logIn()
		self.signInCompletion = signInCompletion
	}

	func vkWillAuthorize() -> Set<VK.Scope> {
		return scope
	}
	
	func vkDidAuthorizeWith(parameters: Dictionary<String, String>) {
		signInCompletion?(nil)
	}
	
	func vkAutorizationFailedWith(error: AuthError) {
		signInCompletion?(error)
	}
	
	func vkDidUnauthorize() {
		
	}
	
	func vkShouldUseTokenPath() -> String? {
		return nil
	}
	
	func vkWillPresentView() -> UIViewController {
		return UIApplication.shared.delegate!.window!!.rootViewController!
	}
	
}


