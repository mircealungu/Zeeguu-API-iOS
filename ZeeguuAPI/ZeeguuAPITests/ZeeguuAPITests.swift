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
	
	private let testLock: NSCondition = NSCondition()
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
		testLock.lock()
	}
	
	override func tearDown() {
		testLock.unlock()
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func DISABLED_testRegister() {
		print("Testing register:")
		ZeeguuAPI.sharedAPI().registerUserWithUsername("JorritO", email: "j.oosterhof.4@student.rug.nl", password: "JLq-E6q-MzL-8pp") { (success) -> Void in
			XCTAssertTrue(success)
			print("success: ", success)
			print("sessionID: ", ZeeguuAPI.sharedAPI().currentSessionID)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testAAALogin() {
		print("Testing login:")
		ZeeguuAPI.sharedAPI().loginWithEmail("j.oosterhof.4@student.rug.nl", password: "JLq-E6q-MzL-8pp") { (success) -> Void in
			XCTAssertTrue(success)
			print("success: ", success)
			print("sessionID: ", ZeeguuAPI.sharedAPI().currentSessionID)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetLearnedLanguage() {
		print("Testing learned language:")
		ZeeguuAPI.sharedAPI().getLearnedLanguage { (langCode) -> Void in
			XCTAssertNotNil(langCode)
			print("langCode: ", langCode)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func DISABLED_testSetLearnedLanguage() {
		print("Testing set learned language:")
		ZeeguuAPI.sharedAPI().setLearnedLanguage("de") { (success) -> Void in
			XCTAssertTrue(success)
			print("success: ", success)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetNativeLanguage() {
		print("Testing native language:")
		ZeeguuAPI.sharedAPI().getNativeLanguage { (langCode) -> Void in
			XCTAssertNotNil(langCode)
			print("langCode: ", langCode)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func DISABLED_testSetNativeLanguage() {
		print("Testing set native language:")
		ZeeguuAPI.sharedAPI().setNativeLanguage("de") { (success) -> Void in
			XCTAssertTrue(success)
			print("success: ", success)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetLearnedAndNativeLanguage() {
		print("Testing learned and native language:")
		ZeeguuAPI.sharedAPI().getLearnedAndNativeLanguage { (dict) -> Void in
			XCTAssertNotNil(dict)
			print("dict: ", dict)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetAvailableLanguages() {
		print("Testing available languages:")
		ZeeguuAPI.sharedAPI().getAvailableLanguages { (array) -> Void in
			XCTAssertNotNil(array)
			print("array: ", array)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetStudyingWords() {
		print("Testing user words:")
		ZeeguuAPI.sharedAPI().getStudyingWords { (array) -> Void in
			XCTAssertNotNil(array)
			print("array: ", array)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetBookmarksByDayWithoutContext() {
		print("Testing bookmarks by day without context:")
		ZeeguuAPI.sharedAPI().getBookmarksByDayWithContext(false) { (dict) -> Void in
			XCTAssertNotNil(dict)
			print("dict: ", dict)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetBookmarksByDayWithContext() {
		print("Testing bookmarks by day with context:")
		ZeeguuAPI.sharedAPI().getBookmarksByDayWithContext(true) { (dict) -> Void in
			XCTAssertNotNil(dict)
			print("dict: ", dict)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func DISABLED_testTranslateWord() {
		print("Testing translating word:")
		ZeeguuAPI.sharedAPI().translateWord("Gipfeltreffen", context: "Unmittelbar vor dem Gipfeltreffen der Europäischen Union mit der Türkei spricht Parlamentspräsident Martin Schulz (SPD) Klartext - eine Vereinbarung von Flüchtlingskontingenten mit der Türkei sei kaum aussichtsreich.", url: "http://www.spiegel.de/politik/ausland/eu-tuerkei-gipfel-streit-um-fluechtlingskontingent-a-1065093.html") { (translation) -> Void in
			
			XCTAssertNotNil(translation)
			print("translation: ", translation)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func DISABLED_testBookmarkWord() {
		print("Testing bookmarking word:")
		ZeeguuAPI.sharedAPI().bookmarkWord("Gipfeltreffen", translation: "summit", context: "Unmittelbar vor dem Gipfeltreffen der Europäischen Union mit der Türkei spricht Parlamentspräsident Martin Schulz (SPD) Klartext - eine Vereinbarung von Flüchtlingskontingenten mit der Türkei sei kaum aussichtsreich.", url: "http://www.spiegel.de/politik/ausland/eu-tuerkei-gipfel-streit-um-fluechtlingskontingent-a-1065093.html", title: "EU-Türkei-Gipfel: Streit um Flüchtlingskontingent") { (bookmarkID) -> Void in
			
			XCTAssertNotNil(bookmarkID)
			print("bookmarkID: ", bookmarkID)
			self.testLock.signal()
		}
		testLock.wait()
		
	}
	
	func DISABLED_testDeleteBookmark() {
		print("Testing deleting bookmark:")
		ZeeguuAPI.sharedAPI().deleteBookmarkWithID("2457") { (success) -> Void in
			XCTAssertTrue(success)
			print("success: ", success)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetExerciseLogWithBookmarkID() {
		print("Testing get exercise log for bookmark:")
		ZeeguuAPI.sharedAPI().getExerciseLogWithBookmarkID("2431") { (dict) -> Void in
			XCTAssertNotNil(dict)
			print("dict: ", dict)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testAddTranslationToBookmark() {
		print("Testing add translation to bookmark:")
		ZeeguuAPI.sharedAPI().addNewTranslationToBookmarkWithID("2431", translation: "fight") { (success) -> Void in
			XCTAssertTrue(success)
			print("success: ", success)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testDeleteTranslationFromBookmark() {
		print("Testing delete translation from bookmark:")
		ZeeguuAPI.sharedAPI().deleteTranslationFromBookmarkWithID("2431", translation: "fight") { (success) -> Void in
			XCTAssertTrue(success)
			print("success: ", success)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetAllTranslationsForBookmark() {
		print("Testing get all translations for bookmark:")
		ZeeguuAPI.sharedAPI().getTranslationsForBookmarkWithID("2431") { (dict) -> Void in
			XCTAssertNotNil(dict)
			print("dict: ", dict)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func DISABLED_testGetNotEncounteredWords() {
		print("Testing get not encountered words:")
		ZeeguuAPI.sharedAPI().getNotEncounteredWordsWithLangCode("de") { (dict) -> Void in
			XCTAssertNotNil(dict)
			print("dict: ", dict)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetKnownBookmarks() {
		print("Testing get known bookmarks:")
		ZeeguuAPI.sharedAPI().getKnownBookmarksWithLangCode("de") { (dict) -> Void in
			XCTAssertNotNil(dict)
			print("dict: ", dict)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetKnownWords() {
		print("Testing get known words:")
		ZeeguuAPI.sharedAPI().getKnownWordsWithLangCode("de") { (dict) -> Void in
			XCTAssertNotNil(dict)
			print("dict: ", dict)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetProbablyKnownWords() {
		print("Testing get probably known words:")
		ZeeguuAPI.sharedAPI().getProbablyKnownWordsWithLangCode("de") { (dict) -> Void in
			XCTAssertNotNil(dict)
			print("dict: ", dict)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetLowerBoundPercentageOfBasicVocabulary() {
		print("Testing get lower bound percentage of basic vocabulary:")
		ZeeguuAPI.sharedAPI().getLowerBoundPercentageOfBasicVocabularyWithCompletion() { (percentage) -> Void in
			XCTAssertNotNil(percentage)
			print("percentage: ", percentage)
			self.testLock.signal()
			
		}
		testLock.wait()
	}
	
	func testGetUpperBoundPercentageOfBasicVocabulary() {
		print("Testing get lower bound percentage of basic vocabulary:")
		ZeeguuAPI.sharedAPI().getUpperBoundPercentageOfBasicVocabularyWithCompletion() { (percentage) -> Void in
			XCTAssertNotNil(percentage)
			print("percentage: ", percentage)
			self.testLock.signal()
			
		}
		testLock.wait()
	}
	
	func DISABLED_testExample() {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct results.
	}
	
	//    func testPerformanceExample() {
	//        // This is an example of a performance test case.
	//        self.measureBlock {
	//            // Put the code you want to measure the time of here.
	//        }
	//    }
	
}
