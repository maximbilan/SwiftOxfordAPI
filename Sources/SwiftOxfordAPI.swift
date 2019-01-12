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
     Request handler.
     
        - Parameters:
            - data: JSON response represented as a dictionary.
            - error: An error object.
     */
    public typealias RequestHandler = ((_ data: [String: Any]?, _ error: Error?) -> Void)
    
	/**
		Initialization.
	
		- Parameters:
			- apiKey: A valid API key.
	*/
	public func start(appId: String, appKey: String) {
		self.appId = appId
		self.appKey = appKey
	}
    
	/**
        Dictionary Entries. Use this to retrieve definitions, pronunciations, example sentences, grammatical information and word origins. It only works for dictionary headwords, so you may need to use the Lemmatron first if your input is likely to be an inflected form (e.g., 'swimming'). This would return the linked headword (e.g., 'swim') which you can then use in the Entries endpoint. Unless specified using a region filter, the default lookup will be the Oxford Dictionary of English (GB).
     
        Response Messages:
     
        404 - no entry is found matching supplied source_lang and id and/or that entry has no senses with translations in the target language.
     
        500 - Internal Error. An error occurred while processing the data.
     
        https://developer.oxforddictionaries.com/documentation#!/Dictionary32entries/get_entries_source_lang_word_id
     
        - Parameters:
            - language: IANA language code.
            - word: An Entry identifier. Case-sensitive.
            - region: Region filter parameter. gb = Oxford Dictionary of English. us = New Oxford American Dictionary.
            - filters: Separate filtering conditions using a semicolon. Conditions take values grammaticalFeatures and/or lexicalCategory and are case-sensitive. To list multiple values in single condition divide them with comma.
            - completion: A completion block.
	*/
    public func entries(language: String, word: String, region: String? = nil, filters: String? = nil, _ completion: @escaping RequestHandler) {
        var urlString = API.entries.url + "/" + language + "/" + word.lowercased()
        if let region = region {
            urlString += "/regions=\(region)"
        }
        if let filters = filters {
            urlString += ((region != nil ? ";" : "/") + filters)
        }
		performRequest(withURL: urlString, httpMethod: API.entries.method, completion)
	}
	
    private func performRequest(withURL urlString: String, httpMethod: String, _ completion: @escaping RequestHandler) {
        guard let urlComponents = URLComponents(string: urlString) else {
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
        urlRequest.httpMethod = httpMethod
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
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
