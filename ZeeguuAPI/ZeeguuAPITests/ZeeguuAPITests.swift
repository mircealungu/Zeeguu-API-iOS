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
		print("Testing get upper bound percentage of basic vocabulary:")
		ZeeguuAPI.sharedAPI().getUpperBoundPercentageOfBasicVocabularyWithCompletion() { (percentage) -> Void in
			XCTAssertNotNil(percentage)
			print("percentage: ", percentage)
			self.testLock.signal()
			
		}
		testLock.wait()
	}
	
	func testGetLowerBoundPercentageOfExtendedVocabulary() {
		print("Testing get lower bound percentage of extended vocabulary:")
		ZeeguuAPI.sharedAPI().getLowerBoundPercentageOfExtendedVocabularyWithCompletion() { (percentage) -> Void in
			XCTAssertNotNil(percentage)
			print("percentage: ", percentage)
			self.testLock.signal()
			
		}
		testLock.wait()
	}
	
	func testGetUpperBoundPercentageOfExtendedVocabulary() {
		print("Testing get upper bound percentage of extended vocabulary:")
		ZeeguuAPI.sharedAPI().getUpperBoundPercentageOfExtendedVocabularyWithCompletion() { (percentage) -> Void in
			XCTAssertNotNil(percentage)
			print("percentage: ", percentage)
			self.testLock.signal()
			
		}
		testLock.wait()
	}
	
	func testGetPercentageOfProbablyKnownBookmarkedWords() {
		print("Testing get percentage of probably known bookmarked words:")
		ZeeguuAPI.sharedAPI().getPercentageOfProbablyKnownBookmarkedWordsWithCompletion() { (percentage) -> Void in
			XCTAssertNotNil(percentage)
			print("percentage: ", percentage)
			self.testLock.signal()
			
		}
		testLock.wait()
	}
	
	func testGetLearnedBookmarks() {
		print("Testing get learned bookmarks:")
		ZeeguuAPI.sharedAPI().getLearnedBookmarksWithLangCode("de") { (dict) -> Void in
			XCTAssertNotNil(dict)
			print("dict: ", dict)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetNotLookedUpWords() {
		print("Testing get not looked up words:")
		ZeeguuAPI.sharedAPI().getNotLookedUpWordsWithLangCode("de") { (dict) -> Void in
			XCTAssertNotNil(dict)
			print("dict: ", dict)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetDifficultyForTexts() {
		print("Testing get difficulty for texts:")
		ZeeguuAPI.sharedAPI().getDifficultyForTexts(["Ein Wagen ist ein von Rädern getragenes mehrspuriges Fahrzeug. Es gibt eine Überlappung mit dem Begriff Karre(n). Eine Kutsche ist ein gefedertes Fuhrwerk, also ein gefederter, von Zugtieren gezogener, gedeckter Wagen. Die Verbindung der Radachsen bzw. des Fahrgestells mit den feststehenden Teilen des Wagens, der Ladefläche oder dem Wagenkasten, kann unterschiedlich gestaltet sein. Sind Räder und Achsen starr verbunden spricht man vom Radsatz. Bei dieser Konstruktion kann die Achse auch als Welle bezeichnet werden. Dreht sich die Achse nicht mit, so wird der innere, ihr aufsitzende Ring des Rades als Nabe bezeichnet. Lässt sich die Achse, oder Teile davon, um einen vertikalen Drehpunkt bewegen, was Kurvenfahrten erleichtert, so spricht man von einer Lenkung. In der Frühzeit des Wagenbaus wurde das Abgleiten der Räder von den Achsen durch Achsnägel verhindert, die durch die Achse geschlagen wurden. Bei den gelenkten Wagen war die Einheit aus Deichsel und Vorderachse (Drehschemel) durch einen metallenen sogenannten Reibnagel drehbar mit dem übrigen Wagen verbunden. Von Zugtieren gezogene Wagen werden Fuhrwerk genannt. Das älteste Zugtier für Radfahrzeuge war das Rind (Kuh oder Ochse), zum stärksten und schnellsten wurde später das Pferd, das wendigste ist das Maultier. Als Zugtiere sind z.B. auch Esel und Kamel einsetzbar. Von Menschen bewegte einfache Wagen werden als Handwagen bzw. Hand- oder Schubkarren bezeichnet. Fuhrwerke, Handwagen und Anhänger werden mittels einer oder zwei Deichseln gelenkt. Für Zugtiere gab bzw. gibt es ein Geschirr. Bei Motorantrieb unterscheidet man motorisierte Wagen, die auch Platz für den Transport von Fahrgästen und Material bieten, Kraftwagen = Automobile (Autos) im Straßenverkehr, Triebwagen im Schienenverkehr, von Zugmaschinen, auf bzw. in denen im Wesentlichen nur Maschine, Fahrzeugführer und Brennstoff Platz haben, also Traktoren und im Schienenverkehr Lokomotiven. Pedalgetriebene Fahrzeuge werden auch dann nicht als Wagen bezeichnet, wenn sie mehrspurig sind. Weichen sie sehr stark vom Erscheinungsbild eines Fahrrades ab, so werden sie mit dem englischen Kürzel HPV benannt (human powered vehicle). Postwagen wurden schon in der „Postkutschenzeit“ großzügig auch dann als Postkutschen bezeichnet, wenn die Federung fehlte."], langCode: "de") { (dict) -> Void in
			XCTAssertNotNil(dict)
			print("dict: ", dict)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetLearnabilityForTexts() {
		print("Testing get learnability for texts:")
		ZeeguuAPI.sharedAPI().getLearnabilityForTexts(["Ein Wagen ist ein von Rädern getragenes mehrspuriges Fahrzeug. Es gibt eine Überlappung mit dem Begriff Karre(n). Eine Kutsche ist ein gefedertes Fuhrwerk, also ein gefederter, von Zugtieren gezogener, gedeckter Wagen. Die Verbindung der Radachsen bzw. des Fahrgestells mit den feststehenden Teilen des Wagens, der Ladefläche oder dem Wagenkasten, kann unterschiedlich gestaltet sein. Sind Räder und Achsen starr verbunden spricht man vom Radsatz. Bei dieser Konstruktion kann die Achse auch als Welle bezeichnet werden. Dreht sich die Achse nicht mit, so wird der innere, ihr aufsitzende Ring des Rades als Nabe bezeichnet. Lässt sich die Achse, oder Teile davon, um einen vertikalen Drehpunkt bewegen, was Kurvenfahrten erleichtert, so spricht man von einer Lenkung. In der Frühzeit des Wagenbaus wurde das Abgleiten der Räder von den Achsen durch Achsnägel verhindert, die durch die Achse geschlagen wurden. Bei den gelenkten Wagen war die Einheit aus Deichsel und Vorderachse (Drehschemel) durch einen metallenen sogenannten Reibnagel drehbar mit dem übrigen Wagen verbunden. Von Zugtieren gezogene Wagen werden Fuhrwerk genannt. Das älteste Zugtier für Radfahrzeuge war das Rind (Kuh oder Ochse), zum stärksten und schnellsten wurde später das Pferd, das wendigste ist das Maultier. Als Zugtiere sind z.B. auch Esel und Kamel einsetzbar. Von Menschen bewegte einfache Wagen werden als Handwagen bzw. Hand- oder Schubkarren bezeichnet. Fuhrwerke, Handwagen und Anhänger werden mittels einer oder zwei Deichseln gelenkt. Für Zugtiere gab bzw. gibt es ein Geschirr. Bei Motorantrieb unterscheidet man motorisierte Wagen, die auch Platz für den Transport von Fahrgästen und Material bieten, Kraftwagen = Automobile (Autos) im Straßenverkehr, Triebwagen im Schienenverkehr, von Zugmaschinen, auf bzw. in denen im Wesentlichen nur Maschine, Fahrzeugführer und Brennstoff Platz haben, also Traktoren und im Schienenverkehr Lokomotiven. Pedalgetriebene Fahrzeuge werden auch dann nicht als Wagen bezeichnet, wenn sie mehrspurig sind. Weichen sie sehr stark vom Erscheinungsbild eines Fahrrades ab, so werden sie mit dem englischen Kürzel HPV benannt (human powered vehicle). Postwagen wurden schon in der „Postkutschenzeit“ großzügig auch dann als Postkutschen bezeichnet, wenn die Federung fehlte."], langCode: "de") { (dict) -> Void in
			XCTAssertNotNil(dict)
			print("dict: ", dict)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetContentFromURLs() {
		print("Testing get content from urls:")
		ZeeguuAPI.sharedAPI().getContentFromURLs(["http://www.t-online.de/nachrichten/deutschland/id_76314572/frank-juergen-weise-geraet-wegen-langer-asylverfahren-in-die-kritik.html", "http://www.derbund.ch/wirtschaft/unternehmen-und-konjunktur/die-bankenriesen-in-den-bergkantonen/story/26984250", "http://www.computerbase.de/2015-11/bundestag-parlament-beschliesst-das-ende-vom-routerzwang-erneut/"]) { (dict) -> Void in
			XCTAssertNotNil(dict)
			print("dict: ", dict)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testLookup() {
		print("Testing lookup, leaving toLangCode nil:")
		ZeeguuAPI.sharedAPI().lookupFromLangCode("de", term: "Kampf") { (success) -> Void in
			XCTAssertTrue(success)
			print("success: ", success)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testLookupWithToLangCode() {
		print("Testing lookup, leaving toLangCode nil:")
		ZeeguuAPI.sharedAPI().lookupFromLangCode("de", term: "Kampf", toLangCode: "en") { (success) -> Void in
			XCTAssertTrue(success)
			print("success: ", success)
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
