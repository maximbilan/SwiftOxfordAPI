//
//  AppDelegate.swift
//  SwiftOxfordAPI
//
//  Created by Maxim on 11/11/18.
//  Copyright © 2018 maximbilan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		SwiftOxfordAPI.shared.start(appId: "APP ID HERE", appKey: "APP KEY HERE")
		
		return true
	}

}
