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
		
        SwiftOxfordAPI.shared.entries(language: "en", word: "queen", region: "us", filters: "grammaticalFeatures=singular,past;lexicalCategory=noun") { [weak self] (data, error) in
            self?.handleResponse(data, error)
        }
	}

    @objc func handleResponse(_ data: [String: Any]?, _ error: Error?) {
        if let data = data {
            print(data)
        } else {
            if let localizedDescr = error?.localizedDescription {
                print(localizedDescr)
            }
        }
    }
    
}
