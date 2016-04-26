//
//  ZeeguuAPITests.swift
//  ZeeguuAPITests
//
//  Created by Jorrit Oosterhof on 28-11-15.
//  Copyright © 2015 Jorrit Oosterhof.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import XCTest
@testable import ZeeguuAPI

class ZeeguuAPITests: XCTestCase {
    
    static let TEST_TEXT = "Ein Wagen ist ein von Rädern getragenes mehrspuriges Fahrzeug. Es gibt eine Überlappung mit dem Begriff Karre(n). Eine Kutsche ist ein gefedertes Fuhrwerk, also ein gefederter, von Zugtieren gezogener, gedeckter Wagen. Die Verbindung der Radachsen bzw. des Fahrgestells mit den feststehenden Teilen des Wagens, der Ladefläche oder dem Wagenkasten, kann unterschiedlich gestaltet sein. Sind Räder und Achsen starr verbunden spricht man vom Radsatz. Bei dieser Konstruktion kann die Achse auch als Welle bezeichnet werden. Dreht sich die Achse nicht mit, so wird der innere, ihr aufsitzende Ring des Rades als Nabe bezeichnet. Lässt sich die Achse, oder Teile davon, um einen vertikalen Drehpunkt bewegen, was Kurvenfahrten erleichtert, so spricht man von einer Lenkung. In der Frühzeit des Wagenbaus wurde das Abgleiten der Räder von den Achsen durch Achsnägel verhindert, die durch die Achse geschlagen wurden. Bei den gelenkten Wagen war die Einheit aus Deichsel und Vorderachse (Drehschemel) durch einen metallenen sogenannten Reibnagel drehbar mit dem übrigen Wagen verbunden. Von Zugtieren gezogene Wagen werden Fuhrwerk genannt. Das älteste Zugtier für Radfahrzeuge war das Rind (Kuh oder Ochse), zum stärksten und schnellsten wurde später das Pferd, das wendigste ist das Maultier. Als Zugtiere sind z.B. auch Esel und Kamel einsetzbar. Von Menschen bewegte einfache Wagen werden als Handwagen bzw. Hand- oder Schubkarren bezeichnet. Fuhrwerke, Handwagen und Anhänger werden mittels einer oder zwei Deichseln gelenkt. Für Zugtiere gab bzw. gibt es ein Geschirr. Bei Motorantrieb unterscheidet man motorisierte Wagen, die auch Platz für den Transport von Fahrgästen und Material bieten, Kraftwagen = Automobile (Autos) im Straßenverkehr, Triebwagen im Schienenverkehr, von Zugmaschinen, auf bzw. in denen im Wesentlichen nur Maschine, Fahrzeugführer und Brennstoff Platz haben, also Traktoren und im Schienenverkehr Lokomotiven. Pedalgetriebene Fahrzeuge werden auch dann nicht als Wagen bezeichnet, wenn sie mehrspurig sind. Weichen sie sehr stark vom Erscheinungsbild eines Fahrrades ab, so werden sie mit dem englischen Kürzel HPV benannt (human powered vehicle). Postwagen wurden schon in der „Postkutschenzeit“ großzügig auch dann als Postkutschen bezeichnet, wenn die Federung fehlte."
	
	private let testLock: NSCondition = NSCondition()
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
		ZeeguuAPI.sharedAPI().enableDebugOutput = true
		testLock.lock()
	}
	
	override func tearDown() {
		testLock.unlock()
		ZeeguuAPI.sharedAPI().enableDebugOutput = false
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
	
	func testGetUserDetails() {
		print("Testing get user details:")
		ZeeguuAPI.sharedAPI().getUserDetails { (dict) -> Void in
			XCTAssertNotNil(dict)
			print("dict: ", dict)
			self.testLock.signal()
		}
		self.testLock.wait()
	}
	
	func testZZZLogout() {
		print("Testing logout:")
		ZeeguuAPI.sharedAPI().logout { (success) -> Void in
			XCTAssertTrue(success);
			print("success: ", success)
			self.testLock.signal()
		}
		testLock.wait()
		XCTAssertFalse(ZeeguuAPI.sharedAPI().isLoggedIn)
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
	
	func testSetLearnedLanguage() {
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
	
	func testSetNativeLanguage() {
		print("Testing set native language:")
		ZeeguuAPI.sharedAPI().setNativeLanguage("en") { (success) -> Void in
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
	
	func testGetAvailableNativeLanguages() {
		print("Testing available native languages:")
		ZeeguuAPI.sharedAPI().getAvailableNativeLanguages { (array) -> Void in
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
	
	func testTranslateWord() {
		print("Testing translating word:")
		ZeeguuAPI.sharedAPI().translateWord("Gipfeltreffen", title: "EU-Türkei-Gipfel: Streit um Flüchtlingskontingent", context: "Unmittelbar vor dem Gipfeltreffen der Europäischen Union mit der Türkei spricht Parlamentspräsident Martin Schulz (SPD) Klartext - eine Vereinbarung von Flüchtlingskontingenten mit der Türkei sei kaum aussichtsreich.", url: "http://www.spiegel.de/politik/ausland/eu-tuerkei-gipfel-streit-um-fluechtlingskontingent-a-1065093.html") { (dict) -> Void in
			
			XCTAssertNotNil(dict)
			print("translation: ", dict)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testTranslateOtherWord() {
		print("Testing translating another word:")
		ZeeguuAPI.sharedAPI().translateWord("buchstäblich", title: "Flüchtlinge: Angela Merkel spricht von historischer Bewährungsprobe für Europa", context: "\"Was wir im Fernsehen gesehen haben, kommt nun buchstäblich bis an unsere Haustür\", sagte die CDU-Vorsitzende.", url: "http://www.spiegel.de/politik/deutschland/fluechtlinge-angela-merkel-spricht-von-historischer-bewaehrungsprobe-fuer-europa-a-1067685.html") { (dict) -> Void in

			XCTAssertNotNil(dict)
			print("translation: ", dict)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testTranslateUmlautWord() {
		print("Testing translating word:")
		ZeeguuAPI.sharedAPI().translateWord("über", title: "", context: "über", url: "") { (dict) -> Void in
			XCTAssertNotNil(dict)
			print("translation: ", dict)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testBookmarkWord() {
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
		ZeeguuAPI.sharedAPI().getDifficultyForTexts([ZeeguuAPITests.TEST_TEXT], langCode: "de") { (difficulties) in
			XCTAssertNotNil(difficulties)
			print("difficulties: ", difficulties)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetLearnabilityForTexts() {
		print("Testing get learnability for texts:")
		ZeeguuAPI.sharedAPI().getLearnabilityForTexts([ZeeguuAPITests.TEST_TEXT], langCode: "de") { (dict) -> Void in
			XCTAssertNotNil(dict)
			print("dict: ", dict)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetContentFromURLs() {
		print("Testing get content from urls:")
		ZeeguuAPI.sharedAPI().getContentFromURLs(["http://www.t-online.de/nachrichten/deutschland/id_76314572/frank-juergen-weise-geraet-wegen-langer-asylverfahren-in-die-kritik.html", "http://www.derbund.ch/wirtschaft/unternehmen-und-konjunktur/die-bankenriesen-in-den-bergkantonen/story/26984250", "http://www.computerbase.de/2015-11/bundestag-parlament-beschliesst-das-ende-vom-routerzwang-erneut/", "http://www.spiegel.de/panorama/justiz/beate-zschaepe-im-nsu-prozess-was-sie-ausgesagt-hat-a-1066805.html"]) { (contents) in
			XCTAssertNotNil(contents)
			print("contents: ", contents)
			self.testLock.signal()
		}
		testLock.wait()
	}
	
	func testGetFeedsAtURL() {
		print("Test getting feeds at url:")
		ZeeguuAPI.sharedAPI().getFeedsAtUrl("http://www.spiegel.de") { (feeds) -> Void in
			XCTAssertNotNil(feeds)
			print("feeds: ", feeds)
			self.testLock.signal()
		}
		self.testLock.wait()
	}
	
	func testGetFeedsAtURL2() {
		print("Test getting feeds at url:")
		ZeeguuAPI.sharedAPI().getFeedsAtUrl("http://www.welt.de") { (feeds) -> Void in
			XCTAssertNotNil(feeds)
			print("feeds: ", feeds)
			self.testLock.signal()
		}
		self.testLock.wait()
	}
	
	func testGetFeedsAtURL3() {
		print("Test getting feeds at url:")
		ZeeguuAPI.sharedAPI().getFeedsAtUrl("http://www.bild.de") { (feeds) -> Void in
			XCTAssertNotNil(feeds)
			print("feeds: ", feeds)
			self.testLock.signal()
		}
		self.testLock.wait()
	}
	
	func testGetFeedsAtURL4() {
		print("Test getting feeds at url:")
		ZeeguuAPI.sharedAPI().getFeedsAtUrl("http://www.zeit.de/index") { (feeds) -> Void in
			XCTAssertNotNil(feeds)
			print("feeds: ", feeds)
			self.testLock.signal()
		}
		self.testLock.wait()
	}
	
	func testGetFeedsAtURL5() {
		print("Test getting feeds at url:")
		ZeeguuAPI.sharedAPI().getFeedsAtUrl("http://www.tagesschau.de") { (feeds) -> Void in
			XCTAssertNotNil(feeds)
			print("feeds: ", feeds)
			self.testLock.signal()
		}
		self.testLock.wait()
	}
	
	func testGetFeedsAtURL6() {
		print("Test getting feeds at url:")
		ZeeguuAPI.sharedAPI().getFeedsAtUrl("http://www.handelsblatt.com") { (feeds) -> Void in
			XCTAssertNotNil(feeds)
			print("feeds: ", feeds)
			self.testLock.signal()
		}
		self.testLock.wait()
	}
	
	func testGetFeedsBeingFollowed() {
		print("Test getting feeds being followed:")
		ZeeguuAPI.sharedAPI().getFeedsBeingFollowed() { (dict) -> Void in
			XCTAssertNotNil(dict)
			print("dict: ", dict)
			self.testLock.signal()
		}
		self.testLock.wait()
	}
	
	func testStartFollowingFeeds() {
		print("Test start following feeds:")
		ZeeguuAPI.sharedAPI().startFollowingFeeds(["http://www.bild.de/rss-feeds/rss-16725492,feed=home.bild.html"]) { (success) -> Void in
			XCTAssertTrue(success)
			print("success: ", success)
			self.testLock.signal()
		}
		self.testLock.wait()
	}
	
	func testStartFollowingFeeds2() {
		print("Test start following feeds:")
		ZeeguuAPI.sharedAPI().startFollowingFeeds(["http://www.spiegel.de/index.rss", "http://www.spiegel.de/schlagzeilen/index.rss"]) { (success) -> Void in
			XCTAssertTrue(success)
			print("success: ", success)
			self.testLock.signal()
		}
		self.testLock.wait()
	}
	
	func testStartFollowingFeeds3() {
		print("Test start following feeds:")
		ZeeguuAPI.sharedAPI().startFollowingFeeds(["http://newsfeed.zeit.de/index"]) { (success) -> Void in
			XCTAssertTrue(success)
			print("success: ", success)
			self.testLock.signal()
		}
		self.testLock.wait()
	}
	
	func testStartFollowingFeeds4() {
		print("Test start following feeds:")
		ZeeguuAPI.sharedAPI().startFollowingFeeds(["http://www.handelsblatt.com/contentexport/feed/top-themen/"]) { (success) -> Void in
			XCTAssertTrue(success)
			print("success: ", success)
			self.testLock.signal()
		}
		self.testLock.wait()
	}
	
	func testStartFollowingFeeds5() {
		print("Test start following feeds:")
		ZeeguuAPI.sharedAPI().startFollowingFeeds(["http://www.tagesschau.de/xml/rss2"]) { (success) -> Void in
			XCTAssertTrue(success)
			print("success: ", success)
			self.testLock.signal()
		}
		self.testLock.wait()
	}
	
	func DISABLED_testStopFollowingFeed() {
		print("Test stop following feeds:")
		ZeeguuAPI.sharedAPI().stopFollowingFeed("1") { (success) -> Void in
			XCTAssertTrue(success)
			print("success: ", success)
			self.testLock.signal()
		}
		self.testLock.wait()
	}
	
	func testGetFeedItems() {
		print("Test getting feed items:")
		ZeeguuAPI.sharedAPI().getFeedItemsForFeed(Feed(id: "8", title: "Spiegel", url: "http://www.spiegel.de/schlagzeilen/index.rss", description: "Spiegel beschrijving", language: "de", imageURL: "niets")) { (articles) -> Void in
			XCTAssertNotNil(articles)
			print("articles: ", articles)
			self.testLock.signal()
		}
		self.testLock.wait()
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
