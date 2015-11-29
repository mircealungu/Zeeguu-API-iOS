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
	
	private var currentSessionID: Int
	
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
	
	public func addUserWithUserName(userName: String, email: String, password: String) {
		
	}
}
