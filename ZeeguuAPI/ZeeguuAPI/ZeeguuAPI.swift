//
//  ZeeguuAPI.swift
//  ZeeguuAPI
//
//  Created by Jorrit Oosterhof on 28-11-15.
//  Copyright © 2015 Jorrit Oosterhof. All rights reserved.
//

import UIKit

/// This class is a gateway to the Zeeguu API. You can use the instance of this class to communicate with the Zeeguu API.
public class ZeeguuAPI {
	private static let instance = ZeeguuAPI()
	
	var currentSessionID: Int {
		didSet {
			let def = NSUserDefaults.standardUserDefaults()
			def.setObject(currentSessionID, forKey: ZeeguuAPI.sessionIDKey)
		}
	}
	
	/// Check if a user is logged in.
	///
	/// - returns: `true` if a user is logged in, `false` otherwise.
	public var isLoggedIn: Bool {
		get {
			return currentSessionID != 0
		}
	}
	
	/// Get the `ZeeguuAPI` instance. This method is the only way to get an instance of the ZeeguuAPI class.
	///
	/// - returns: The shared `ZeeguuAPI` instance.
	public static func sharedAPI() -> ZeeguuAPI {
		return instance;
	}
	
	private init() {
		self.currentSessionID = 0
		let def = NSUserDefaults.standardUserDefaults()
		if (def.objectForKey(ZeeguuAPI.sessionIDKey) != nil) {
			self.currentSessionID = def.objectForKey(ZeeguuAPI.sessionIDKey)!.integerValue
		}
	}
	
	/// Registers a user.
	///
	/// After the user is registered and logged in, you can use the ZeeguuAPI object to make requests on behalf of the user.
	///
	/// - parameter username: The username of the user to register.
	/// - parameter email: The email address of the user.
	/// - parameter password: The password of the user.
	/// - parameter completion: A block that receives a success parameter, which is true if the user was logged in successfully.
	public func registerUserWithUsername(username: String, email: String, password: String, completion: (success: Bool) -> Void) {
		let request = self.zeeguuAPIRequestWithEndPoint(ZeeguuAPIEndpoint.AddUser, pathComponents: [email], method: HTTPMethod.POST, parameters: ["username":username, "password":password])
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			if (response != nil) {
				let sesID = Int(response!)
				if (sesID != nil) {
					self.currentSessionID = sesID!
				}
				completion(success: true)
			} else {
				completion(success: false)
			}
		}
	}
	
	/// Logs a user in.
	///
	/// After the user is logged in, you can use the ZeeguuAPI object to make requests on behalf of the user.
	/// 
	/// - parameter email: The email address of the user to log in.
	/// - parameter password: The password of the user.
	/// - parameter completion: A block that receives a success parameter, which is true if the user was logged in successfully.
	public func loginWithEmail(email: String, password: String, completion: (success: Bool) -> Void) {
		let request = self.zeeguuAPIRequestWithEndPoint(ZeeguuAPIEndpoint.Session, pathComponents: [email], method: HTTPMethod.POST, parameters: ["password":password])
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			if (response != nil) {
				let sesID = Int(response!)
				if (sesID != nil) {
					self.currentSessionID = sesID!
				}
				completion(success: true)
			} else {
				completion(success: false)
			}
		}
	}
	
	/// Returns the language code of the learned langugage of the logged in user.
	///
	/// - parameter completion: A block that will receive a language code of the learned language or nil if the request couldn't be completed.
	public func learnedLanguage(completion: (langCode: String?) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(langCode: nil)
		}
		let request = self.zeeguuAPIRequestWithEndPoint(ZeeguuAPIEndpoint.LearnedLanguage, pathComponents: nil, method: HTTPMethod.GET, parameters: nil)
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			if (response != nil) {
				completion(langCode: response!)
			} else {
				completion(langCode: nil)
			}
		}
	}
	
	/// Sets the language code of the learned langugage of the logged in user.
	///
	/// - parameter newLanguageCode: The language code of the language that will be the new learned language.
	/// - parameter completion: A block that will receive a boolean indication if the request succeeded.
	public func setLearnedLanguage(newLanguageCode: String, completion: (success: Bool) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(success: false)
		}
		let request = self.zeeguuAPIRequestWithEndPoint(ZeeguuAPIEndpoint.LearnedLanguage, pathComponents: [newLanguageCode], method: HTTPMethod.POST, parameters: nil)
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			if (response != nil && response! == "OK") {
				completion(success: true)
			} else {
				completion(success: false)
			}
		}
	}
	
	/// Returns the language code of the native langugage of the logged in user.
	///
	/// - parameter completion: A block that will receive a language code of the native language or nil if the request couldn't be completed.
	public func nativeLanguage(completion: (langCode: String?) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(langCode: nil)
		}
		let request = self.zeeguuAPIRequestWithEndPoint(ZeeguuAPIEndpoint.NativeLanguage, pathComponents: nil, method: HTTPMethod.GET, parameters: nil)
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			if (response != nil) {
				completion(langCode: response!)
			} else {
				completion(langCode: nil)
			}
		}
	}
	
	/// Sets the language code of the native langugage of the logged in user.
	///
	/// - parameter newLanguageCode: The language code of the language that will be the new native language.
	/// - parameter completion: A block that will receive a boolean indication if the request succeeded.
	public func setNativeLanguage(newLanguageCode: String, completion: (success: Bool) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(success: false)
		}
		let request = self.zeeguuAPIRequestWithEndPoint(ZeeguuAPIEndpoint.NativeLanguage, pathComponents: [newLanguageCode], method: HTTPMethod.POST, parameters: nil)
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			if (response != nil && response! == "OK") {
				completion(success: true)
			} else {
				completion(success: false)
			}
		}
	}
	
	/// Returns the language code of the learned and native langugage of the logged in user.
	///
	/// - parameter completion: A block that will receive a `JSON` object, which contains the dictornary with language codes of the learned and native language.
	public func learnedAndNativeLanguage(completion: (dict: JSON?) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(dict: nil)
		}
		let request = self.zeeguuAPIRequestWithEndPoint(ZeeguuAPIEndpoint.LearnedAndNativeLanguage, pathComponents: nil, method: HTTPMethod.GET, parameters: nil)
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			if (response != nil) {
				completion(dict: JSON.parse(response!))
			} else {
				completion(dict: nil)
			}
		}
	}
	
	/// Returns the language codes of all available languages that the Zeeguu API supports.
	///
	/// - parameter completion: A block that will receive a `JSON` object, which contains the array with the language codes.
	public func availableLanguages(completion: (array: JSON?) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(array: nil)
		}
		let request = self.zeeguuAPIRequestWithEndPoint(ZeeguuAPIEndpoint.AvailableLanguages, pathComponents: nil, method: HTTPMethod.GET, parameters: nil)
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			if (response != nil) {
				completion(array: JSON.parse(response!))
			} else {
				completion(array: nil)
			}
		}
	}
	
	/// Returns the words that the user is currently studying.
	///
	/// - parameter completion: A block that will receive a `JSON` object, which contains the list of words.
	public func studyingWords(completion: (array: JSON?) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(array: nil)
		}
		let request = self.zeeguuAPIRequestWithEndPoint(ZeeguuAPIEndpoint.UserWords, pathComponents: nil, method: HTTPMethod.GET, parameters: nil)
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			if (response != nil) {
				completion(array: JSON.parse(response!))
			} else {
				completion(array: nil)
			}
		}
	}
}
