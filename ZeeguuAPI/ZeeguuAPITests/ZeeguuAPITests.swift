//
//  ZeeguuAPITests.swift
//  ZeeguuAPITests
//
//  Created by Jorrit Oosterhof on 28-11-15.
//  Copyright © 2015 Jorrit Oosterhof. All rights reserved.
//

import XCTest
@testable import ZeeguuAPI

class ZeeguuAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
		let l = NSCondition()
		l.lock()
		print("Testing login:")
		ZeeguuAPI.sharedAPI().loginWithEmail("j.oosterhof.4@student.rug.nl", password: "JLq-E6q-MzL-8pp") { (success) -> Void in
			print("success: ", success)
			print("sessionID: ", ZeeguuAPI.sharedAPI().currentSessionID)
			l.signal()
		}
		l.wait()
		l.unlock()
		
		print("Testing learned language:")
		l.lock()
		ZeeguuAPI.sharedAPI().learnedLanguage { (langCode) -> Void in
			print("langCode: ", langCode)
			l.signal()
		}
		l.wait()
		l.unlock()
		
//		print("Testing set learned language:")
//		l.lock()
//		ZeeguuAPI.sharedAPI().setLearnedLanguage("de") { (success) -> Void in
//			print("success: ", success)
//			l.signal()
//		}
//		l.wait()
		//		l.unlock()
		
		print("Testing native language:")
		l.lock()
		ZeeguuAPI.sharedAPI().nativeLanguage { (langCode) -> Void in
			print("langCode: ", langCode)
			l.signal()
		}
		l.wait()
		l.unlock()
		
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
