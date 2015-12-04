//
//  ZeeguuAPI.swift
//  ZeeguuAPI
//
//  Created by Jorrit Oosterhof on 28-11-15.
//  Copyright © 2015 Jorrit Oosterhof. All rights reserved.
//

import UIKit

/// This class is a gateway to the Zeeguu API. You can use the instance of this class obtained by `ZeeguuAPI.sharedAPI()` to communicate with the Zeeguu API.
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
		let request = self.requestWithEndPoint(.AddUser, pathComponents: [email], method: .POST, parameters: ["username":username, "password":password])
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
		let request = self.requestWithEndPoint(.Session, pathComponents: [email], method: .POST, parameters: ["password":password])
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
	
	/// Retrieves the language code of the learned langugage of the logged in user.
	///
	/// - parameter completion: A block that will receive a language code of the learned language or nil if the request couldn't be completed.
	public func getLearnedLanguage(completion: (langCode: String?) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(langCode: nil)
		}
		let request = self.requestWithEndPoint(.LearnedLanguage, pathComponents: nil, method: .GET, parameters: nil)
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
		let request = self.requestWithEndPoint(.LearnedLanguage, pathComponents: [newLanguageCode], method: .POST, parameters: nil)
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			self.checkBooleanResponse(response, error: error, completion: completion);
		}
	}
	
	/// Retrieves the language code of the native langugage of the logged in user.
	///
	/// - parameter completion: A block that will receive a language code of the native language or nil if the request couldn't be completed.
	public func getNativeLanguage(completion: (langCode: String?) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(langCode: nil)
		}
		let request = self.requestWithEndPoint(.NativeLanguage, pathComponents: nil, method: .GET, parameters: nil)
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
		let request = self.requestWithEndPoint(.NativeLanguage, pathComponents: [newLanguageCode], method: .POST, parameters: nil)
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			self.checkBooleanResponse(response, error: error, completion: completion);
		}
	}
	
	/// Retrieves the language code of the learned and native langugage of the logged in user.
	///
	/// - parameter completion: A block that will receive a `JSON` object, which contains the dictornary with language codes of the learned and native language.
	public func getLearnedAndNativeLanguage(completion: (dict: JSON?) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(dict: nil)
		}
		let request = self.requestWithEndPoint(.LearnedAndNativeLanguage, pathComponents: nil, method: .GET, parameters: nil)
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			self.checkJSONResponse(response, error: error, completion: completion)
		}
	}
	
	/// Retrieves the language codes of all available languages that the Zeeguu API supports.
	///
	/// - parameter completion: A block that will receive a `JSON` object, which contains the array with the language codes.
	public func getAvailableLanguages(completion: (array: JSON?) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(array: nil)
		}
		let request = self.requestWithEndPoint(.AvailableLanguages, pathComponents: nil, method: .GET, parameters: nil)
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			self.checkJSONResponse(response, error: error, completion: completion)
		}
	}
	
	/// Retrieves the words that the user is currently studying.
	///
	/// - parameter completion: A block that will receive a `JSON` object, which contains the list of words.
	public func getStudyingWords(completion: (array: JSON?) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(array: nil)
		}
		let request = self.requestWithEndPoint(.UserWords, pathComponents: nil, method: .GET, parameters: nil)
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			self.checkJSONResponse(response, error: error, completion: completion)
		}
	}
	
	/// Retrieves the bookmarks of the user, organized by date.
	///
	/// - parameter withContext: If `withContext` is `true`, the text where a bookmark was found is also returned. If `false`, only the bookmark (without context) is returned.
	/// - parameter completion: A block that will receive a `JSON` object, which contains the list of bookmarks.
	public func getBookmarksByDayWithContext(withContext: Bool, completion: (dict: JSON?) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(dict: nil)
		}
		var pathComponents: Array<String>
		if (withContext) {
			pathComponents = ["with_context"]
		} else {
			pathComponents = ["without_context"]
		}
		let request = self.requestWithEndPoint(.BookmarksByDay, pathComponents: pathComponents, method: .GET, parameters: nil)
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			self.checkJSONResponse(response, error: error, completion: completion)
		}
	}
	
	/// Retrieves the translation of the given word from the user's learned language to the user's native language.
	///
	/// - parameter word: The word to translate.
	/// - parameter context: The context in which the word appeared.
	/// - parameter url: The url of the article in which the word was translated.
	/// - parameter completion: A block that will receive a string containing the translation of `word`.
	public func translateWord(word: String, context: String, url: String, completion: (translation: String?) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(translation: nil)
		}
		
		self.getLearnedAndNativeLanguage { (dict) -> Void in
			if (dict != nil) {
				if let learned = dict!["learned"].string, native = dict!["native"].string {
					let request = self.requestWithEndPoint(.Translate, pathComponents: [learned, native], method: .POST, parameters: ["context": context, "word": word, "url": url])
					self.sendAsynchronousRequest(request) { (response, error) -> Void in
						if (response != nil) {
							completion(translation: response!)
						} else {
							completion(translation: nil)
						}
					}
				}
			}
			completion(translation: nil)
		}
	}
	
	/// Adds the translation of the given word to the user's bookmarks and Retrieves its ID.
	///
	/// - parameter word: The word to bookmark.
	/// - parameter translation: The translation of `word`.
	/// - parameter context: The context in which the word appeared.
	/// - parameter url: The url of the article in which the word was found.
	/// - parameter title: The title of the article in which the word was found.
	/// - parameter completion: A block that will receive a string containing the id of the newly made bookmark.
	public func bookmarkWord(word: String, translation: String, context: String, url: String, title: String?, completion: (bookmarkID: String?) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(bookmarkID: nil)
		}
		
		self.getLearnedAndNativeLanguage { (dict) -> Void in
			if (dict != nil) {
				if let learned = dict!["learned"].string, native = dict!["native"].string {
					var params = ["context": context, "url": url]
					if (title != nil) {
						params["title"] = title
					}
					let request = self.requestWithEndPoint(.BookmarkWithContext, pathComponents: [learned, word, native, translation], method: .POST, parameters: params)
					self.sendAsynchronousRequest(request) { (response, error) -> Void in
						if (response != nil) {
							completion(bookmarkID: response!)
						} else {
							completion(bookmarkID: nil)
						}
					}
				}
			}
			completion(bookmarkID: nil)
		}
	}
	
	/// Deletes the bookmark with the given ID.
	///
	/// - parameter bookmarkID: The ID of the bookmark to delete.
	/// - parameter completion: A block that will receive a boolean indicating if the bookmark could be deleted or not.
	public func deleteBookmarkWithID(bookmarkID: String, completion: (success: Bool) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(success: false)
		}
		let request = self.requestWithEndPoint(.DeleteBookmark, pathComponents: [bookmarkID], method: .POST, parameters: nil)
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			self.checkBooleanResponse(response, error: error, completion: completion);
		}
	}
	
	/// Retrieves the exercise log of the user for a given bookmark.
	///
	/// - parameter bookmarkID: The ID of the bookmark for which to get the exercise log.
	/// - parameter completion: A block that will receive a `JSON` object, which contains the exercise log.
	public func getExerciseLogWithBookmarkID(bookmarkID: String, completion: (dict: JSON?) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(dict: nil)
		}
		let request = self.requestWithEndPoint(.GetExerciseLogForBookmark, pathComponents: [bookmarkID], method: .GET, parameters: nil)
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			self.checkJSONResponse(response, error: error, completion: completion)
		}
	}
	
	/// Adds a translation to the bookmark with the given ID.
	///
	/// - parameter bookmarkID: The ID of the bookmark.
	/// - parameter translation: The translation to add to the bookmark.
	/// - parameter completion: A block that will receive a boolean indicating if the translation could be added or not.
	public func addNewTranslationToBookmarkWithID(bookmarkID: String, translation: String, completion: (success: Bool) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(success: false)
		}
		let request = self.requestWithEndPoint(.AddNewTranslationToBookmark, pathComponents: [translation, bookmarkID], method: .POST, parameters: nil)
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			self.checkBooleanResponse(response, error: error, completion: completion);
		}
	}
	
	/// Deletes a translation from the bookmark with the given ID.
	///
	/// - parameter bookmarkID: The ID of the bookmark.
	/// - parameter translation: The translation to remove from the bookmark.
	/// - parameter completion: A block that will receive a boolean indicating if the translation could be deleted or not.
	public func deleteTranslationFromBookmarkWithID(bookmarkID: String, translation: String, completion: (success: Bool) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(success: false)
		}
		let request = self.requestWithEndPoint(.DeleteTranslationFromBookmark, pathComponents: [bookmarkID, translation], method: .POST, parameters: nil)
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			self.checkBooleanResponse(response, error: error, completion: completion);
		}
	}
	
	/// Retrieves all translations for the bookmark with the given ID.
	///
	/// - parameter bookmarkID: The ID of the bookmark.
	/// - parameter completion: A block that will receive a boolean indicating if the translation could be deleted or not.
	public func getTranslationsForBookmarkWithID(bookmarkID: String, completion: (dict: JSON?) -> Void) {
		if (!self.checkIfLoggedIn()) {
			return completion(dict: nil)
		}
		let request = self.requestWithEndPoint(.GetTranslationsForBookmark, pathComponents: [bookmarkID], method: .GET, parameters: nil)
		self.sendAsynchronousRequest(request) { (response, error) -> Void in
			self.checkJSONResponse(response, error: error, completion: completion)
		}
	}
}
