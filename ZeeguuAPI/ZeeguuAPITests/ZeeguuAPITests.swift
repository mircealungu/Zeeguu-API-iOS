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
		
		//		print("Testing set native language:")
		//		l.lock()
		//		ZeeguuAPI.sharedAPI().setNativeLanguage("de") { (success) -> Void in
		//			print("success: ", success)
		//			l.signal()
		//		}
		//		l.wait()
		//		l.unlock()
		
		print("Testing learned and native language:")
		l.lock()
		ZeeguuAPI.sharedAPI().learnedAndNativeLanguage { (dict) -> Void in
			print("dict: ", dict)
			l.signal()
		}
		l.wait()
		l.unlock()
		
		print("Testing available languages:")
		l.lock()
		ZeeguuAPI.sharedAPI().availableLanguages { (array) -> Void in
			print("array: ", array)
			l.signal()
		}
		l.wait()
		l.unlock()
		
		print("Testing user words:")
		l.lock()
		ZeeguuAPI.sharedAPI().studyingWords { (array) -> Void in
			print("array: ", array)
			l.signal()
		}
		l.wait()
		l.unlock()
		
		print("Testing bookmarks by day without context:")
		l.lock()
		ZeeguuAPI.sharedAPI().bookmarksByDayWithContext(false) { (dict) -> Void in
			print("dict: ", dict)
			l.signal()
		}
		l.wait()
		l.unlock()
		
		print("Testing bookmarks by day with context:")
		l.lock()
		ZeeguuAPI.sharedAPI().bookmarksByDayWithContext(true) { (dict) -> Void in
			print("dict: ", dict)
			l.signal()
		}
		l.wait()
		l.unlock()
		
//		print("Testing translating word:")
//		l.lock()
//		ZeeguuAPI.sharedAPI().translateWord("Gipfeltreffen", context: "Unmittelbar vor dem Gipfeltreffen der Europäischen Union mit der Türkei spricht Parlamentspräsident Martin Schulz (SPD) Klartext - eine Vereinbarung von Flüchtlingskontingenten mit der Türkei sei kaum aussichtsreich.", url: "http://www.spiegel.de/politik/ausland/eu-tuerkei-gipfel-streit-um-fluechtlingskontingent-a-1065093.html") { (translation) -> Void in
//			
//			print("translation: ", translation)
//			l.signal()
//		}
//		l.wait()
//		l.unlock()
		
		
//		print("Testing bookmarking word:")
//		l.lock()
//		
//		ZeeguuAPI.sharedAPI().bookmarkWord("Gipfeltreffen", translation: "summit", context: "Unmittelbar vor dem Gipfeltreffen der Europäischen Union mit der Türkei spricht Parlamentspräsident Martin Schulz (SPD) Klartext - eine Vereinbarung von Flüchtlingskontingenten mit der Türkei sei kaum aussichtsreich.", url: "http://www.spiegel.de/politik/ausland/eu-tuerkei-gipfel-streit-um-fluechtlingskontingent-a-1065093.html", title: "EU-Türkei-Gipfel: Streit um Flüchtlingskontingent") { (bookmarkID) -> Void in
//			
//			print("bookmarkID: ", bookmarkID)
//			l.signal()
//		}
//		l.wait()
//		l.unlock()
		
    }
	
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }
	
}
