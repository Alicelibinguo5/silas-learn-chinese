import XCTest
import SwiftUI
@testable import SilasLearnsChinese

final class SilasLearnsChineseTests: XCTestCase {
    
    // MARK: - Vocabulary Tests
    
    func testVocabularyManager() {
        let vocabularyManager = VocabularyManager.shared
        
        // Test that vocabulary is loaded
        XCTAssertFalse(vocabularyManager.allWords.isEmpty, "Vocabulary should not be empty")
        XCTAssertEqual(vocabularyManager.allWords.count, 31, "Should have 31 vocabulary words")
        
        // Test category filtering
        let colorWords = vocabularyManager.words(for: .colors)
        XCTAssertEqual(colorWords.count, 6, "Should have 6 color words")
        
        let numberWords = vocabularyManager.words(for: .numbers)
        XCTAssertEqual(numberWords.count, 10, "Should have 10 number words")
        
        // Test random words
        let randomWords = vocabularyManager.randomWords(count: 5)
        XCTAssertEqual(randomWords.count, 5, "Should return 5 random words")
        
        // Test difficulty filtering
        let level1Words = vocabularyManager.words(forDifficulty: 1)
        XCTAssertEqual(level1Words.count, 31, "All words should be level 1")
    }
    
    func testVocabularyWord() {
        let word = VocabularyWord(
            chinese: "红色",
            pinyin: "hóng sè",
            english: "red",
            category: .colors,
            audioFileName: "hongse",
            imageFileName: "red",
            difficultyLevel: 1
        )
        
        XCTAssertEqual(word.chinese, "红色")
        XCTAssertEqual(word.pinyin, "hóng sè")
        XCTAssertEqual(word.english, "red")
        XCTAssertEqual(word.category, .colors)
        XCTAssertEqual(word.difficultyLevel, 1)
    }
    
    // MARK: - Progress Manager Tests
    
    func testProgressManager() {
        let progressManager = ProgressManager.shared
        
        // Test initial state
        XCTAssertEqual(progressManager.totalWordsLearned(), 0, "Should start with 0 learned words")
        XCTAssertEqual(progressManager.totalSessions(), 0, "Should start with 0 sessions")
        XCTAssertEqual(progressManager.averageScore(), 0, "Should start with 0 average score")
        
        // Test word learning
        progressManager.markWordAsLearned("红色", masteryLevel: .familiar)
        XCTAssertEqual(progressManager.totalWordsLearned(), 1, "Should have 1 learned word")
        
        // Test session recording
        let session = LearningSession(
            sessionType: .colors,
            wordsStudied: ["红色", "蓝色"],
            score: 85,
            duration: 120,
            completed: true
        )
        progressManager.recordSession(session)
        
        XCTAssertEqual(progressManager.totalSessions(), 1, "Should have 1 session")
        XCTAssertEqual(progressManager.averageScore(), 85, "Average score should be 85")
    }
    
    func testWordMastery() {
        let exposed = WordMastery.exposed
        XCTAssertEqual(exposed.displayName, "Exposed")
        XCTAssertEqual(exposed.chineseName, "接触过")
        
        let mastered = WordMastery.mastered
        XCTAssertEqual(mastered.displayName, "Mastered")
        XCTAssertEqual(mastered.chineseName, "掌握")
    }
    
    // MARK: - Character Manager Tests
    
    func testCharacterManager() {
        let characterManager = CharacterManager.shared
        
        // Test characters are loaded
        XCTAssertFalse(characterManager.characters.isEmpty, "Characters should not be empty")
        XCTAssertEqual(characterManager.characters.count, 5, "Should have 5 characters")
        
        // Test main character
        let mainCharacter = characterManager.getMainCharacter()
        XCTAssertNotNil(mainCharacter, "Should have main character")
        XCTAssertEqual(mainCharacter?.name, "Little Dinosaur")
        XCTAssertEqual(mainCharacter?.chineseName, "小恐龙")
        
        // Test teacher character
        let teacherCharacter = characterManager.getTeacherCharacter()
        XCTAssertNotNil(teacherCharacter, "Should have teacher character")
        XCTAssertEqual(teacherCharacter?.name, "Teacher Panda")
        
        // Test friend characters
        let friends = characterManager.getFriendCharacters()
        XCTAssertEqual(friends.count, 3, "Should have 3 friend characters")
    }
    
    func testCharacterMood() {
        let characterManager = CharacterManager.shared
        
        // Test mood updates
        characterManager.updateMainCharacterMood(progress: 10)
        XCTAssertEqual(characterManager.activeCharacter?.currentMood, .curious)
        
        characterManager.updateMainCharacterMood(progress: 30)
        XCTAssertEqual(characterManager.activeCharacter?.currentMood, .encouraging)
        
        characterManager.updateMainCharacterMood(progress: 90)
        XCTAssertEqual(characterManager.activeCharacter?.currentMood, .proud)
    }
    
    // MARK: - Audio Service Tests
    
    func testAudioService() {
        let audioService = AudioService.shared
        
        // Test initial state
        XCTAssertFalse(audioService.isPlaying, "Should not be playing initially")
        XCTAssertTrue(audioService.backgroundMusicEnabled, "Background music should be enabled")
        XCTAssertTrue(audioService.pronunciationEnabled, "Pronunciation should be enabled")
        
        // Test volume
        audioService.setVolume(0.5)
        XCTAssertEqual(audioService.volume, 0.5, "Volume should be set to 0.5")
        
        // Test settings
        audioService.toggleBackgroundMusic()
        XCTAssertFalse(audioService.backgroundMusicEnabled, "Background music should be disabled")
        
        audioService.togglePronunciation()
        XCTAssertFalse(audioService.pronunciationEnabled, "Pronunciation should be disabled")
    }
    
    // MARK: - Learning Session Tests
    
    func testLearningSession() {
        let session = LearningSession(
            sessionType: .colors,
            wordsStudied: ["红色", "蓝色", "绿色"],
            score: 90,
            duration: 180,
            completed: true
        )
        
        XCTAssertEqual(session.sessionType, .colors)
        XCTAssertEqual(session.wordsStudied.count, 3)
        XCTAssertEqual(session.score, 90)
        XCTAssertEqual(session.duration, 180)
        XCTAssertTrue(session.completed)
    }
    
    // MARK: - Milestone Tests
    
    func testMilestone() {
        let milestone = LearningMilestone(type: .firstWord, data: ["word": "红色"])
        
        XCTAssertEqual(milestone.type, .firstWord)
        XCTAssertEqual(milestone.data["word"], "红色")
        XCTAssertEqual(milestone.type.displayName, "First Word Learned")
        XCTAssertEqual(milestone.type.chineseName, "第一个词")
    }
    
    // MARK: - UI Component Tests
    
    func testStatCard() {
        let statCard = StatCard(title: "Test", value: "10", icon: "star.fill", color: .blue)
        
        // Test that StatCard can be created without errors
        XCTAssertNotNil(statCard)
    }
    
    func testContentViewCreation() {
        let contentView = ContentView()
        
        // Test that ContentView can be created without errors
        XCTAssertNotNil(contentView)
    }
    
    // MARK: - Category Tests
    
    func testVocabularyCategories() {
        let colors = VocabularyCategory.colors
        XCTAssertEqual(colors.displayName, "颜色 (Colors)")
        XCTAssertEqual(colors.chineseName, "颜色")
        
        let numbers = VocabularyCategory.numbers
        XCTAssertEqual(numbers.displayName, "数字 (Numbers)")
        XCTAssertEqual(numbers.chineseName, "数字")
        
        let animals = VocabularyCategory.animals
        XCTAssertEqual(animals.displayName, "动物 (Animals)")
        XCTAssertEqual(animals.chineseName, "动物")
    }
    
    // MARK: - Learning Context Tests
    
    func testCharacterMessages() {
        let characterManager = CharacterManager.shared
        
        let correctMessage = characterManager.getEncouragingMessage(for: .correctAnswer)
        XCTAssertEqual(correctMessage, "Excellent! 太棒了!")
        
        let incorrectMessage = characterManager.getEncouragingMessage(for: .incorrectAnswer)
        XCTAssertEqual(incorrectMessage, "Try again! 再试一次!")
        
        let milestoneMessage = characterManager.getEncouragingMessage(for: .milestoneAchieved)
        XCTAssertEqual(milestoneMessage, "Congratulations! 恭喜!")
    }
    
    // MARK: - Performance Tests
    
    func testVocabularyPerformance() {
        measure {
            let vocabularyManager = VocabularyManager.shared
            _ = vocabularyManager.randomWords(count: 10)
        }
    }
    
    func testProgressPerformance() {
        measure {
            let progressManager = ProgressManager.shared
            progressManager.markWordAsLearned("测试", masteryLevel: .familiar)
        }
    }
}
