//
//  ZeeguuAPIEndpoints.swift
//  ZeeguuAPI
//
//  Created by Jorrit Oosterhof on 29-11-15.
//  Copyright © 2015 Jorrit Oosterhof. All rights reserved.
//

import UIKit

enum ZeeguuAPIEndpoint: String {
	case AddNewTranslationToBookmark = "add_new_translation_to_bookmark"
	case AddUser = "add_user"
	case AvailableLanguages = "available_languages"
	case BookmarksByDay = "bookmarks_by_day"
	case BookmarkWithContext = "bookmark_with_context"
	case DeleteBookmark = "delete_bookmark"
	case DeleteTranslationFromBookmark = "delete_translation_from_bookmark"
	case GetContentFromURL = "get_content_from_url"
	case GetDifficultyForText = "get_difficulty_for_text"
	case GetExerciseLogForBookmark = "get_exercise_log_for_bookmark"
	case GetKnownBookmarks = "get_known_bookmarks"
	case GetKnownWords = "get_known_words"
	case GetLearnabilityForText = "get_learnability_for_text"
	case GetLearnedBookmarks = "get_learned_bookmarks"
	case GetLowerBoundPercentageOfBasicVocabulary = "get_lower_bound_percentage_of_basic_vocabulary"
	case GetLowerBoundPercentageOfExtendedVocabulary = "get_lower_bound_percentage_of_extended_vocabulary"
	case GetNotEncounteredWords = "get_not_encountered_words"
	case GetNotLookedUpWords = "get_not_looked_up_words"
	case GetPage = "get_page"
	case GetPercentageOfProbablyKnownBookmarkedWords = "get_percentage_of_probably_known_bookmarked_words"
	case GetProbablyKnownWords = "get_probably_known_words"
	case GetTranslationsForBookmark = "get_translations_for_bookmark"
	case GetUpperBoundPercentageOfBasicVocabulary = "get_upper_bound_percentage_of_basic_vocabulary"
	case GetUpperBoundPercentageOfExtendedVocabulary = "get_upper_bound_percentage_of_extended_vocabulary"
	case LearnedAndNativeLanguage = "learned_and_native_language"
	case LearnedLanguage = "learned_language"
	case Lookup = "lookup"
	case NativeLanguage = "native_language"
	case Session = "session"
	case Translate = "translate"
	case UserWords = "user_words"
	case Validate = "validate"
}
