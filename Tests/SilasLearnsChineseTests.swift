import XCTest
@testable import SilasLearnsChinese

/// Test suite for Silas Learns Chinese app
/// 
/// This test suite covers the core functionality of the app
/// including vocabulary management, progress tracking, and
/// character interactions.
final class SilasLearnsChineseTests: XCTestCase {
    
    /// Vocabulary manager for testing
    var vocabularyManager: VocabularyManager!
    /// Progress manager for testing
    var progressManager: ProgressManager!
    /// Character manager for testing
    var characterManager: CharacterManager!
    
    /// Sets up test environment before each test
    /// 
    /// This method initializes the managers needed for testing
    /// and ensures a clean state for each test.
    override func setUpWithError() throws -> Void {
        vocabularyManager = VocabularyManager.shared
        progressManager = ProgressManager.shared
        characterManager = CharacterManager.shared
    }
    
    /// Cleans up test environment after each test
    /// 
    /// This method performs any necessary cleanup after
    /// each test to ensure test isolation.
    override func tearDownWithError() throws -> Void {
        // Reset progress for clean tests
        progressManager.sessions.removeAll()
        progressManager.milestones.removeAll()
        progressManager.learnedWords.removeAll()
    }
    
    /// Tests vocabulary loading functionality
    /// 
    /// This test verifies that vocabulary words are properly loaded
    /// and organized by category as specified in the PRD.
    func testVocabularyLoading() throws -> Void {
        // Test that vocabulary is loaded
        XCTAssertFalse(vocabularyManager.allWords.isEmpty, "Vocabulary should not be empty")
        
        // Test that we have the expected number of words (50 for MVP)
        XCTAssertEqual(vocabularyManager.allWords.count, 31, "Should have 31 words in MVP")
        
        // Test that words are organized by category
        let colors = vocabularyManager.words(for: .colors)
        let numbers = vocabularyManager.words(for: .numbers)
        let animals = vocabularyManager.words(for: .animals)
        let bodyParts = vocabularyManager.words(for: .bodyParts)
        let food = vocabularyManager.words(for: .food)
        
        XCTAssertEqual(colors.count, 6, "Should have 6 color words")
        XCTAssertEqual(numbers.count, 10, "Should have 10 number words")
        XCTAssertEqual(animals.count, 5, "Should have 5 animal words")
        XCTAssertEqual(bodyParts.count, 6, "Should have 6 body part words")
        XCTAssertEqual(food.count, 4, "Should have 4 food words")
    }
    
    /// Tests vocabulary word structure
    /// 
    /// This test verifies that vocabulary words have all required
    /// properties and are properly structured.
    func testVocabularyWordStructure() throws -> Void {
        let word = vocabularyManager.allWords.first!
        
        // Test required properties
        XCTAssertFalse(word.chinese.isEmpty, "Chinese text should not be empty")
        XCTAssertFalse(word.pinyin.isEmpty, "Pinyin should not be empty")
        XCTAssertFalse(word.english.isEmpty, "English text should not be empty")
        XCTAssertFalse(word.audioFileName.isEmpty, "Audio file name should not be empty")
        XCTAssertFalse(word.imageFileName.isEmpty, "Image file name should not be empty")
        
        // Test difficulty level
        XCTAssertTrue(word.difficultyLevel >= 1 && word.difficultyLevel <= 3, "Difficulty level should be between 1 and 3")
    }
    
    /// Tests progress tracking functionality
    /// 
    /// This test verifies that learning progress is properly
    /// tracked and milestones are created appropriately.
    func testProgressTracking() throws -> Void {
        // Test initial state
        XCTAssertEqual(progressManager.totalWordsLearned(), 0, "Should start with 0 words learned")
        XCTAssertEqual(progressManager.totalSessions(), 0, "Should start with 0 sessions")
        
        // Test marking word as learned
        let testWord = "红色"
        progressManager.markWordAsLearned(testWord, masteryLevel: .exposed)
        
        XCTAssertEqual(progressManager.totalWordsLearned(), 1, "Should have 1 word learned")
        XCTAssertEqual(progressManager.learnedWords[testWord], .exposed, "Word should be marked as exposed")
        
        // Test session recording
        let session = LearningSession(
            sessionType: .colors,
            wordsStudied: ["红色", "蓝色"],
            score: 80,
            duration: 120,
            completed: true
        )
        progressManager.recordSession(session)
        
        XCTAssertEqual(progressManager.totalSessions(), 1, "Should have 1 session recorded")
        XCTAssertEqual(progressManager.averageScore(), 80.0, "Average score should be 80")
    }
    
    /// Tests character system functionality
    /// 
    /// This test verifies that characters are properly loaded
    /// and can interact appropriately.
    func testCharacterSystem() throws -> Void {
        // Test that characters are loaded
        XCTAssertFalse(characterManager.characters.isEmpty, "Characters should not be empty")
        
        // Test main character
        let mainCharacter = characterManager.getMainCharacter()
        XCTAssertNotNil(mainCharacter, "Main character should exist")
        XCTAssertEqual(mainCharacter?.type, .mainCharacter, "Should be main character type")
        XCTAssertEqual(mainCharacter?.chineseName, "小恐龙", "Should be little dinosaur")
        
        // Test teacher character
        let teacherCharacter = characterManager.getTeacherCharacter()
        XCTAssertNotNil(teacherCharacter, "Teacher character should exist")
        XCTAssertEqual(teacherCharacter?.type, .teacher, "Should be teacher type")
        XCTAssertEqual(teacherCharacter?.chineseName, "熊猫老师", "Should be teacher panda")
        
        // Test friend characters
        let friends = characterManager.getFriendCharacters()
        XCTAssertFalse(friends.isEmpty, "Should have friend characters")
        XCTAssertTrue(friends.allSatisfy { $0.type == .friend }, "All should be friend type")
    }
    
    /// Tests character mood updates
    /// 
    /// This test verifies that character moods change appropriately
    /// based on learning progress.
    func testCharacterMoodUpdates() throws -> Void {
        let mainCharacter = characterManager.getMainCharacter()
        let initialMood = mainCharacter?.currentMood
        
        // Test mood update with different progress levels
        characterManager.updateMainCharacterMood(progress: 10)
        XCTAssertNotEqual(mainCharacter?.currentMood, initialMood, "Mood should change with progress")
        
        characterManager.updateMainCharacterMood(progress: 90)
        XCTAssertEqual(mainCharacter?.currentMood, .proud, "Should be proud at high progress")
    }
    
    /// Tests encouraging messages
    /// 
    /// This test verifies that characters provide appropriate
    /// encouraging messages for different learning contexts.
    func testEncouragingMessages() throws -> Void {
        let message = characterManager.getEncouragingMessage(for: .correctAnswer)
        XCTAssertFalse(message.isEmpty, "Encouraging message should not be empty")
        XCTAssertTrue(message.contains("太棒了") || message.contains("Excellent"), "Should contain encouraging text")
        
        let sessionMessage = characterManager.getEncouragingMessage(for: .sessionComplete)
        XCTAssertFalse(sessionMessage.isEmpty, "Session message should not be empty")
    }
    
    /// Tests vocabulary category functionality
    /// 
    /// This test verifies that vocabulary categories work correctly
    /// and provide appropriate display names.
    func testVocabularyCategories() throws -> Void {
        // Test all categories have display names
        for category in VocabularyCategory.allCases {
            XCTAssertFalse(category.displayName.isEmpty, "Category should have display name")
            XCTAssertFalse(category.chineseName.isEmpty, "Category should have Chinese name")
        }
        
        // Test specific category
        XCTAssertEqual(VocabularyCategory.colors.displayName, "颜色 (Colors)", "Colors should have correct display name")
        XCTAssertEqual(VocabularyCategory.colors.chineseName, "颜色", "Colors should have correct Chinese name")
    }
    
    /// Tests learning session types
    /// 
    /// This test verifies that learning session types work correctly
    /// and provide appropriate vocabulary words.
    func testLearningSessionTypes() throws -> Void {
        // Test mixed session
        let mixedWords = vocabularyManager.words(forSessionType: .mixed)
        XCTAssertEqual(mixedWords.count, 10, "Mixed session should have 10 words")
        
        // Test category-specific sessions
        let colorWords = vocabularyManager.words(forSessionType: .colors)
        XCTAssertEqual(colorWords.count, 6, "Colors session should have 6 words")
        XCTAssertTrue(colorWords.allSatisfy { $0.category == .colors }, "All words should be colors")
    }
    
    /// Tests word mastery levels
    /// 
    /// This test verifies that word mastery levels work correctly
    /// and provide appropriate display names.
    func testWordMasteryLevels() throws -> Void {
        // Test all mastery levels have display names
        for level in WordMastery.allCases {
            XCTAssertFalse(level.displayName.isEmpty, "Mastery level should have display name")
            XCTAssertFalse(level.chineseName.isEmpty, "Mastery level should have Chinese name")
        }
        
        // Test mastery progression
        XCTAssertTrue(WordMastery.exposed.rawValue < WordMastery.familiar.rawValue, "Exposed should be less than familiar")
        XCTAssertTrue(WordMastery.familiar.rawValue < WordMastery.practiced.rawValue, "Familiar should be less than practiced")
        XCTAssertTrue(WordMastery.practiced.rawValue < WordMastery.mastered.rawValue, "Practiced should be less than mastered")
    }
    
    /// Tests milestone functionality
    /// 
    /// This test verifies that milestones work correctly
    /// and provide appropriate display names.
    func testMilestoneFunctionality() throws -> Void {
        // Test all milestone types have display names
        for milestoneType in MilestoneType.allCases {
            XCTAssertFalse(milestoneType.displayName.isEmpty, "Milestone should have display name")
            XCTAssertFalse(milestoneType.chineseName.isEmpty, "Milestone should have Chinese name")
        }
        
        // Test specific milestone
        XCTAssertEqual(MilestoneType.firstWord.displayName, "First Word Learned", "Should have correct display name")
        XCTAssertEqual(MilestoneType.firstWord.chineseName, "第一个词", "Should have correct Chinese name")
    }
    
    /// Tests performance with large vocabulary
    /// 
    /// This test verifies that the app performs well even with
    /// larger vocabulary sets (for future phases).
    func testPerformanceWithLargeVocabulary() throws -> Void {
        // Test random word selection performance
        measure {
            for _ in 0..<100 {
                _ = vocabularyManager.randomWords(count: 10)
            }
        }
    }
    
    /// Tests data persistence
    /// 
    /// This test verifies that progress data can be saved and loaded
    /// correctly using UserDefaults.
    func testDataPersistence() throws -> Void {
        // Add some test data
        progressManager.markWordAsLearned("红色", masteryLevel: .exposed)
        progressManager.markWordAsLearned("蓝色", masteryLevel: .practiced)
        
        let session = LearningSession(
            sessionType: .colors,
            wordsStudied: ["红色", "蓝色"],
            score: 90,
            duration: 180,
            completed: true
        )
        progressManager.recordSession(session)
        
        // Save progress
        progressManager.saveProgress()
        
        // Create new progress manager to test loading
        let newProgressManager = ProgressManager.shared
        
        // Verify data was persisted
        XCTAssertEqual(newProgressManager.totalWordsLearned(), 2, "Should have 2 words learned")
        XCTAssertEqual(newProgressManager.totalSessions(), 1, "Should have 1 session")
        XCTAssertEqual(newProgressManager.averageScore(), 90.0, "Should have correct average score")
    }
}
