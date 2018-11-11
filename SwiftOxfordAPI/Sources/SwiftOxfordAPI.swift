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
	public func start(_ appId: String, _ appKey: String) {
		self.appId = appId
		self.appKey = appKey
	}
	
	/*
	*/
	public func entries(_ language: String, _ word: String, _ source: String, _ format: String = "text", _ model: String = "base", _ completion: @escaping ((_ text: String?, _ error: Error?) -> Void)) {
		guard var urlComponents = URLComponents(string: API.entries.url + "/" + language + "/" + word.lowercased()) else {
			completion(nil, nil)
			return
		}
		
//		var queryItems = [URLQueryItem]()
//		queryItems.append(URLQueryItem(name: "key", value: apiKey))
//		queryItems.append(URLQueryItem(name: "q", value: q))
//		queryItems.append(URLQueryItem(name: "target", value: target))
//		queryItems.append(URLQueryItem(name: "source", value: source))
//		queryItems.append(URLQueryItem(name: "format", value: format))
//		queryItems.append(URLQueryItem(name: "model", value: model))
//		urlComponents.queryItems = queryItems
		
		guard let url = urlComponents.url else {
			completion(nil, nil)
			return
		}
		
		var urlRequest = URLRequest(url: url)
		
		urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
		urlRequest.addValue(appId, forHTTPHeaderField: "app_id")
		urlRequest.addValue(appKey, forHTTPHeaderField: "app_key")
		
		urlRequest.httpMethod = API.entries.method
		
		let task = session.dataTask(with: urlRequest) { (data, response, error) in
			guard let data = data,								// is there data
				let response = response as? HTTPURLResponse,	// is there HTTP response
				(200 ..< 300) ~= response.statusCode,			// is statusCode 2XX
				error == nil else {								// was there no error, otherwise ...
					completion(nil, error)
					return
			}
			
			guard let object = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]/*, let d = object["data"] as? [String: Any], let translations = d["translations"] as? [[String: String]], let translation = translations.first, let translatedText = translation["translatedText"]*/ else {
				completion(nil, error)
				return
			}
			
			print(object)
			
			completion("", nil)
		}
		task.resume()
	}
	
}
