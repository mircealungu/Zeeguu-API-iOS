//
//  ZeeguuAPI.swift
//  ZeeguuAPI
//
//  Created by Jorrit Oosterhof on 28-11-15.
//  Copyright © 2015 Jorrit Oosterhof. All rights reserved.
//

import UIKit

/// This object can be used to connect to the Zeeguu API.
public class ZeeguuAPI {
	private static let instance = ZeeguuAPI()
	
	var currentSessionID: Int {
		didSet {
			let def = NSUserDefaults.standardUserDefaults()
			def.setObject(currentSessionID, forKey: ZeeguuAPI.sessionIDKey)
		}
	}
	
	/// Returns if a user is logged in currently
	public var isLoggedIn: Bool {
		get {
			return currentSessionID != 0
		}
	}
	
	/// Get the ZeeguuAPI instance
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
	
	/// Add a user with username, email and password. The completion block success parameter is true if the user was added successfully. You can then use the ZeeguuAPI object to make requests.
	public func addUserWithUserName(username: String, email: String, password: String, completion: (success: Bool) -> Void) {
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
	
	/// Log a user in with email and password. The completion block success parameter is true if the user was logged in successfully. You can then use the ZeeguuAPI object to make requests.
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
}
