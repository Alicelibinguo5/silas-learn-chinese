import Foundation

/// Represents a vocabulary word with Chinese and English translations
/// 
/// This model contains the essential information for each vocabulary item
/// including the Chinese characters, pinyin, English translation, and category.
struct VocabularyWord: Identifiable, Codable {
    /// Unique identifier for the vocabulary word
    let id: UUID
    /// Chinese characters
    let chinese: String
    /// Pinyin pronunciation
    let pinyin: String
    /// English translation
    let english: String
    /// Category the word belongs to
    let category: VocabularyCategory
    /// Audio file name for pronunciation
    let audioFileName: String
    /// Image file name for visual representation
    let imageFileName: String
    /// Difficulty level for learning progression
    let difficultyLevel: Int
    
    /// Initializes a new vocabulary word
    /// 
    /// - Parameters:
    ///   - chinese: The Chinese characters
    ///   - pinyin: The pinyin pronunciation
    ///   - english: The English translation
    ///   - category: The vocabulary category
    ///   - audioFileName: The audio file name for pronunciation
    ///   - imageFileName: The image file name for visual representation
    ///   - difficultyLevel: The difficulty level (1-3)
    init(chinese: String, pinyin: String, english: String, category: VocabularyCategory, audioFileName: String, imageFileName: String, difficultyLevel: Int) {
        self.id = UUID()
        self.chinese = chinese
        self.pinyin = pinyin
        self.english = english
        self.category = category
        self.audioFileName = audioFileName
        self.imageFileName = imageFileName
        self.difficultyLevel = difficultyLevel
    }
}

/// Categories for organizing vocabulary words
/// 
/// These categories help organize the learning content and provide
/// a structured approach to vocabulary building.
enum VocabularyCategory: String, CaseIterable, Codable {
    case colors = "colors"
    case numbers = "numbers"
    case animals = "animals"
    case bodyParts = "bodyParts"
    case food = "food"
    
    /// Returns the display name for the category
    var displayName: String {
        switch self {
        case .colors:
            return "颜色 (Colors)"
        case .numbers:
            return "数字 (Numbers)"
        case .animals:
            return "动物 (Animals)"
        case .bodyParts:
            return "身体部位 (Body Parts)"
        case .food:
            return "食物 (Food)"
        }
    }
    
    /// Returns the Chinese name for the category
    var chineseName: String {
        switch self {
        case .colors:
            return "颜色"
        case .numbers:
            return "数字"
        case .animals:
            return "动物"
        case .bodyParts:
            return "身体部位"
        case .food:
            return "食物"
        }
    }
}

/// Manages the vocabulary content for the app
/// 
/// This class provides access to all vocabulary words, organized by category,
/// and includes methods for filtering and retrieving vocabulary based on various criteria.
class VocabularyManager: ObservableObject {
    /// Shared instance for singleton access
    static let shared = VocabularyManager()
    
    /// All vocabulary words in the app
    @Published var allWords: [VocabularyWord] = []
    
    /// Private initializer for singleton pattern
    private init() {
        loadVocabulary()
    }
    
    /// Loads all vocabulary words into the app
    /// 
    /// This method populates the vocabulary list with the 50 basic words
    /// organized by category as specified in the PRD.
    private func loadVocabulary() -> Void {
        allWords = [
            // Colors (颜色) - 6 words
            VocabularyWord(chinese: "红色", pinyin: "hóng sè", english: "red", category: .colors, audioFileName: "hongse", imageFileName: "red", difficultyLevel: 1),
            VocabularyWord(chinese: "蓝色", pinyin: "lán sè", english: "blue", category: .colors, audioFileName: "lanse", imageFileName: "blue", difficultyLevel: 1),
            VocabularyWord(chinese: "绿色", pinyin: "lǜ sè", english: "green", category: .colors, audioFileName: "luse", imageFileName: "green", difficultyLevel: 1),
            VocabularyWord(chinese: "黄色", pinyin: "huáng sè", english: "yellow", category: .colors, audioFileName: "huangse", imageFileName: "yellow", difficultyLevel: 1),
            VocabularyWord(chinese: "粉色", pinyin: "fěn sè", english: "pink", category: .colors, audioFileName: "fense", imageFileName: "pink", difficultyLevel: 1),
            VocabularyWord(chinese: "紫色", pinyin: "zǐ sè", english: "purple", category: .colors, audioFileName: "zise", imageFileName: "purple", difficultyLevel: 1),
            
            // Numbers (数字) - 10 words
            VocabularyWord(chinese: "一", pinyin: "yī", english: "one", category: .numbers, audioFileName: "yi", imageFileName: "one", difficultyLevel: 1),
            VocabularyWord(chinese: "二", pinyin: "èr", english: "two", category: .numbers, audioFileName: "er", imageFileName: "two", difficultyLevel: 1),
            VocabularyWord(chinese: "三", pinyin: "sān", english: "three", category: .numbers, audioFileName: "san", imageFileName: "three", difficultyLevel: 1),
            VocabularyWord(chinese: "四", pinyin: "sì", english: "four", category: .numbers, audioFileName: "si", imageFileName: "four", difficultyLevel: 1),
            VocabularyWord(chinese: "五", pinyin: "wǔ", english: "five", category: .numbers, audioFileName: "wu", imageFileName: "five", difficultyLevel: 1),
            VocabularyWord(chinese: "六", pinyin: "liù", english: "six", category: .numbers, audioFileName: "liu", imageFileName: "six", difficultyLevel: 1),
            VocabularyWord(chinese: "七", pinyin: "qī", english: "seven", category: .numbers, audioFileName: "qi", imageFileName: "seven", difficultyLevel: 1),
            VocabularyWord(chinese: "八", pinyin: "bā", english: "eight", category: .numbers, audioFileName: "ba", imageFileName: "eight", difficultyLevel: 1),
            VocabularyWord(chinese: "九", pinyin: "jiǔ", english: "nine", category: .numbers, audioFileName: "jiu", imageFileName: "nine", difficultyLevel: 1),
            VocabularyWord(chinese: "十", pinyin: "shí", english: "ten", category: .numbers, audioFileName: "shi", imageFileName: "ten", difficultyLevel: 1),
            
            // Animals (动物) - 5 words
            VocabularyWord(chinese: "猫", pinyin: "māo", english: "cat", category: .animals, audioFileName: "mao", imageFileName: "cat", difficultyLevel: 1),
            VocabularyWord(chinese: "狗", pinyin: "gǒu", english: "dog", category: .animals, audioFileName: "gou", imageFileName: "dog", difficultyLevel: 1),
            VocabularyWord(chinese: "鸟", pinyin: "niǎo", english: "bird", category: .animals, audioFileName: "niao", imageFileName: "bird", difficultyLevel: 1),
            VocabularyWord(chinese: "鱼", pinyin: "yú", english: "fish", category: .animals, audioFileName: "yu", imageFileName: "fish", difficultyLevel: 1),
            VocabularyWord(chinese: "恐龙", pinyin: "kǒng lóng", english: "dinosaur", category: .animals, audioFileName: "konglong", imageFileName: "dinosaur", difficultyLevel: 1),
            
            // Body Parts (身体部位) - 6 words
            VocabularyWord(chinese: "头", pinyin: "tóu", english: "head", category: .bodyParts, audioFileName: "tou", imageFileName: "head", difficultyLevel: 1),
            VocabularyWord(chinese: "眼睛", pinyin: "yǎn jīng", english: "eyes", category: .bodyParts, audioFileName: "yanjing", imageFileName: "eyes", difficultyLevel: 1),
            VocabularyWord(chinese: "鼻子", pinyin: "bí zi", english: "nose", category: .bodyParts, audioFileName: "bizi", imageFileName: "nose", difficultyLevel: 1),
            VocabularyWord(chinese: "嘴巴", pinyin: "zuǐ ba", english: "mouth", category: .bodyParts, audioFileName: "zuiba", imageFileName: "mouth", difficultyLevel: 1),
            VocabularyWord(chinese: "手", pinyin: "shǒu", english: "hands", category: .bodyParts, audioFileName: "shou", imageFileName: "hands", difficultyLevel: 1),
            VocabularyWord(chinese: "脚", pinyin: "jiǎo", english: "feet", category: .bodyParts, audioFileName: "jiao", imageFileName: "feet", difficultyLevel: 1),
            
            // Food (食物) - 4 words
            VocabularyWord(chinese: "苹果", pinyin: "píng guǒ", english: "apple", category: .food, audioFileName: "pingguo", imageFileName: "apple", difficultyLevel: 1),
            VocabularyWord(chinese: "香蕉", pinyin: "xiāng jiāo", english: "banana", category: .food, audioFileName: "xiangjiao", imageFileName: "banana", difficultyLevel: 1),
            VocabularyWord(chinese: "米饭", pinyin: "mǐ fàn", english: "rice", category: .food, audioFileName: "mifan", imageFileName: "rice", difficultyLevel: 1),
            VocabularyWord(chinese: "水", pinyin: "shuǐ", english: "water", category: .food, audioFileName: "shui", imageFileName: "water", difficultyLevel: 1),
        ]
    }
    
    /// Returns vocabulary words filtered by category
    /// 
    /// - Parameter category: The category to filter by
    /// - Returns: Array of vocabulary words in the specified category
    func words(for category: VocabularyCategory) -> [VocabularyWord] {
        return allWords.filter { $0.category == category }
    }
    
    /// Returns vocabulary words filtered by difficulty level
    /// 
    /// - Parameter level: The difficulty level (1-3)
    /// - Returns: Array of vocabulary words at the specified difficulty level
    func words(forDifficulty level: Int) -> [VocabularyWord] {
        return allWords.filter { $0.difficultyLevel == level }
    }
    
    /// Returns a random selection of vocabulary words
    /// 
    /// - Parameter count: The number of words to return
    /// - Returns: Array of randomly selected vocabulary words
    func randomWords(count: Int) -> [VocabularyWord] {
        return Array(allWords.shuffled().prefix(count))
    }
    
    /// Returns vocabulary words for a specific learning session
    /// 
    /// - Parameter sessionType: The type of learning session
    /// - Returns: Array of vocabulary words appropriate for the session
    func words(forSessionType sessionType: LearningSessionType) -> [VocabularyWord] {
        switch sessionType {
        case .vocabulary:
            // Return mixed vocabulary for general vocabulary practice
            return randomWords(count: 10)
        case .pronunciation:
            // Return words good for pronunciation practice
            return randomWords(count: 8)
        case .writing:
            // Return simpler words for writing practice
            return words(for: .colors) + words(for: .numbers)
        case .listening:
            // Return varied words for listening practice
            return randomWords(count: 12)
        case .games:
            // Return fun words for games
            return words(for: .animals) + words(for: .colors)
        case .review:
            // Return all words for review
            return allWords
        case .quiz:
            // Return varied words for quizzing
            return randomWords(count: 15)
        case .freePlay:
            // Return all available words for free exploration
            return allWords
        }
    }
}


