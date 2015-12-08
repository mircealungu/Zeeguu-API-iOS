//
//  ZeeguuDefaults.swift
//  ZeeguuAPI
//
//  Created by Jorrit Oosterhof on 28-11-15.
//  Copyright © 2015 Jorrit Oosterhof. All rights reserved.
//

import UIKit

extension ZeeguuAPI {
	static let apiHost: String = "https://zeeguu.unibe.ch"
	static let sessionIDKey: String = "ZeeguuSessionID"
	
	func requestWithEndPoint(endPoint: ZeeguuAPIEndpoint, pathComponents: Array<String>?, method: HTTPMethod, parameters: Dictionary<String, String>?, jsonBody: JSON? = nil) -> NSURLRequest {
		var path: NSString = NSString(string: ZeeguuAPI.apiHost).stringByAppendingPathComponent(endPoint.rawValue)
		
		// Add pathcomponent to the host if there are any (for example, adding <email> to host/add_user: host/add_user/<email>)
		if (pathComponents != nil) {
			for pathComponent in pathComponents! {
				path = path.stringByAppendingPathComponent(pathComponent.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLPathAllowedCharacterSet())!);
			}
		}
		
		// Append session id to url if we have one
		var delimiter = "?"
		if (self.isLoggedIn) {
			path = path.stringByAppendingString("?session=" + String(self.currentSessionID))
			delimiter = "&"
		}
		
		// Convert the parameters (if any) to a string of the form "key1=value1&key2=value2"
		var params = ""
		if (parameters != nil) {
			params = self.httpQueryStringForDictionary(parameters!)
		}
		
		// Add parameters to url if method is GET or jsonBody is not nil
		if ((method == HTTPMethod.GET || jsonBody != nil) && params.characters.count > 0) {
			path = path.stringByAppendingString(delimiter + params)
		}
		
		// Create request with the url
		let url = NSURL(string: path as String)
		let request = NSMutableURLRequest(URL: url!)
		
		// Set request to be POST (if method is POST) and add the parameters to the request
		if (method == HTTPMethod.POST) {
			request.HTTPMethod = method.rawValue
			request.HTTPBody = params.dataUsingEncoding(NSUTF8StringEncoding)
		}
		
		// If jsonBody != nil, overwrite http body with json data
		if let jsonString = jsonBody {
			var requestData: NSData?
			if let str = jsonString.rawString() {
				requestData = str.dataUsingEncoding(NSUTF8StringEncoding)
			} else {
				requestData = "".dataUsingEncoding(NSUTF8StringEncoding)
			}
			
			var requestDataLength: String
			if let length = requestData?.length {
				requestDataLength = (length as NSNumber).stringValue
			} else {
				requestDataLength = "0"
			}
			request.HTTPBody = requestData
			request.setValue("application/json", forHTTPHeaderField: "Content-Type");
			request.setValue(requestDataLength, forHTTPHeaderField: "Content-Length")
		}
		
		return request
	}
	
	func httpQueryStringForDictionary(dict: Dictionary<String, String>) -> String {
		var arr = [String]()
		
		for (key, value) in dict {
			arr.append(key + "=" + value.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
		}
		return arr.joinWithSeparator("&")
	}
	
	func sendAsynchronousRequest(request: NSURLRequest, completion: (response: String?, error: NSError?) -> Void) {
		let session = NSURLSession.sharedSession()
		NSLog("Sending request for url \"%@\": %@\n\n", request.URL!, request);
		let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
			if (data != nil && response != nil && (response! as! NSHTTPURLResponse).statusCode == 200) {
				let response = String(data: data!, encoding: NSUTF8StringEncoding)!
				NSLog("Response from url \"%@\": %@\n\n", request.URL!, response);
				completion(response: response, error: nil)
			} else {
				if (response != nil) {
					NSLog("Response object for url \"%@\": %@\n\n", request.URL!, response!);
				}
				if (error != nil) {
					NSLog("Error for url \"%@\": %@\n\n", request.URL!, error!);
				}
				completion(response: nil, error: error)
			}
		}
		task.resume()
	}
	
	func checkIfLoggedIn() -> Bool {
		if (!self.isLoggedIn) {
			NSLog("There is no user logged in currently!")
			return false
		}
		return true
	}
	
	func checkBooleanResponse(response: String?, error: NSError?, completion: (success: Bool) -> Void) {
		if (response != nil && response == "OK") {
			completion(success: true)
		} else {
			completion(success: false)
		}
	}
	
	func checkJSONResponse(response: String?, error: NSError?, completion: (dict: JSON?) -> Void) {
		if (response != nil) {
			completion(dict: JSON.parse(response!))
		} else {
			completion(dict: nil)
		}
	}
	
	func checkStringResponse(response: String?, error: NSError?, completion: (string: String?) -> Void) {
		if (response != nil) {
			completion(string: response!)
		} else {
			completion(string: nil)
		}
	}
}