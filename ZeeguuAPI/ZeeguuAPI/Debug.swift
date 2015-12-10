//
//  Debug.swift
//  ZeeguuAPI
//
//  Created by Jorrit Oosterhof on 08-12-15.
//  Copyright © 2015 Jorrit Oosterhof. All rights reserved.
//

import UIKit

extension NSURLRequest {
	public func extendedDescription() -> String {
		
		var result = "<\(NSStringFromClass(self.dynamicType)): " + String(format: "%p", self)
		result += "; HTTPMethod=" + (HTTPMethod ?? "nil") + "; URL=\(URL); timeoutInterval=" + String(format: "%.1fs", timeoutInterval) + "> {"
		
		// Add header fields.
		if let headers = allHTTPHeaderFields {
			result += "\nallHTTPHeaderFields {"
			for (key, value) in headers {
				result += "\n\t\(key) : '\(value)'"
			}
			result += "\n}"
		}
		
		if let body = HTTPBody {
			result += "\nHTTPBody {\n " + ((NSString(data: body, encoding: NSASCIIStringEncoding) ?? "") as String) + "}"
		}
		
		return result + "\n}"
	}
	
	public override var debugDescription: String {
		return extendedDescription()
	}
	
	public override var description: String {
		return extendedDescription()
	}
}