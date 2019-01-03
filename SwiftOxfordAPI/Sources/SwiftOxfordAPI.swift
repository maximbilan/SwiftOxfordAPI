//
//  SwiftOxfordAPI.swift
//  SwiftOxfordAPI
//
//  Created by Maxim on 11/11/18.
//  Copyright © 2018 maximbilan. All rights reserved.
//

import Foundation

/// A helper class for using Oxford Dictionaries API.
public class SwiftOxfordAPI {
	
	/// Shared instance.
	public static let shared = SwiftOxfordAPI()
	
	/// API structure.
	private struct API {
		/// Base Oxford Dictionaries API url.
		static let base = "https://od-api.oxforddictionaries.com/api/v1"
		
		/// `entries` endpoint.
		struct entries {
			static let base = "entries"
			static let method = "GET"
			static let url = API.base + "/" + entries.base
		}
	}
    
	/// App identifier.
	private var appId: String!
	/// API key.
	private var appKey: String!
	/// Default URL session.
	private let session = URLSession(configuration: .default)
    
	/**
		Initialization.
	
		- Parameters:
			- apiKey: A valid API key.
	*/
	public func start(appId: String, appKey: String) {
		self.appId = appId
		self.appKey = appKey
	}
    
	/*
	*/
	public func entries(_ language: String, _ word: String, _ completion: @escaping ((_ data: [String: Any]?, _ error: Error?) -> Void)) {
        guard let urlComponents = URLComponents(string: API.entries.url + "/" + language + "/" + word.lowercased()) else {
			completion(nil, nil)
			return
		}
		
		guard let url = urlComponents.url else {
			completion(nil, nil)
			return
		}
		
		var urlRequest = URLRequest(url: url)
		
		urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
		urlRequest.addValue(appId, forHTTPHeaderField: "app_id")
		urlRequest.addValue(appKey, forHTTPHeaderField: "app_key")
		
		urlRequest.httpMethod = API.entries.method
		
		let task = session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            guard let strongSelf = self else {
                return
            }
            
			guard let data = data,
				let response = response as? HTTPURLResponse,
				(200 ..< 300) ~= response.statusCode,
				error == nil else {
					completion(nil, error)
					return
			}
			
			guard let object = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] else {
				completion(nil, error)
				return
			}
			
			completion(object, nil)
		}
		task.resume()
	}
	
}
