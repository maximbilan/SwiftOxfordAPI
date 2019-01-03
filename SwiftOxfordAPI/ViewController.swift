//
//  ViewController.swift
//  SwiftOxfordAPI
//
//  Created by Maxim on 11/11/18.
//  Copyright © 2018 maximbilan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		SwiftOxfordAPI.shared.entries("en", "queen") { (data, error) in
			print(data)
		}
	}

}
