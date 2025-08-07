import Foundation
import SwiftUI

/// Represents a character in the app with personality and animations
/// 
/// This model defines the main characters that guide children through
/// the learning experience, including the friendly dinosaur and supporting characters.
struct AppCharacter: Identifiable, Codable {
    /// Unique identifier for the character
    let id: UUID
    /// The character's name
    let name: String
    /// The character's Chinese name
    let chineseName: String
    /// The character's type/role
    let type: CharacterType
    /// The character's personality traits
    let personality: [PersonalityTrait]
    /// The character's current mood
    var currentMood: CharacterMood
    /// The character's color (for visual representation)
    let color: String
    /// The character's image file name
    let imageFileName: String
    
    /// Initializes a new app character
    /// 
    /// - Parameters:
    ///   - name: The character's English name
    ///   - chineseName: The character's Chinese name
    ///   - type: The character's type/role
    ///   - personality: The character's personality traits
    ///   - color: The character's color
    ///   - imageFileName: The character's image file name
    init(name: String, chineseName: String, type: CharacterType, personality: [PersonalityTrait], color: String, imageFileName: String) {
        self.id = UUID()
        self.name = name
        self.chineseName = chineseName
        self.type = type
        self.personality = personality
        self.currentMood = .happy
        self.color = color
        self.imageFileName = imageFileName
    }
}

/// Types of characters in the app
/// 
/// These character types define the roles and functions
/// of different characters in the learning experience.
enum CharacterType: String, CaseIterable, Codable {
    case mainCharacter = "mainCharacter"
    case teacher = "teacher"
    case helper = "helper"
    case friend = "friend"
    
    /// Returns the display name for the character type
    var displayName: String {
        switch self {
        case .mainCharacter:
            return "Main Character"
        case .teacher:
            return "Teacher"
        case .helper:
            return "Helper"
        case .friend:
            return "Friend"
        }
    }
}

/// Personality traits that define character behavior
/// 
/// These traits influence how characters interact with children
/// and provide different types of encouragement and guidance.
enum PersonalityTrait: String, CaseIterable, Codable {
    case friendly = "friendly"
    case patient = "patient"
    case encouraging = "encouraging"
    case wise = "wise"
    case playful = "playful"
    case curious = "curious"
    case helpful = "helpful"
    
    /// Returns the display name for the personality trait
    var displayName: String {
        switch self {
        case .friendly:
            return "Friendly"
        case .patient:
            return "Patient"
        case .encouraging:
            return "Encouraging"
        case .wise:
            return "Wise"
        case .playful:
            return "Playful"
        case .curious:
            return "Curious"
        case .helpful:
            return "Helpful"
        }
    }
    
    /// Returns the Chinese name for the personality trait
    var chineseName: String {
        switch self {
        case .friendly:
            return "友好"
        case .patient:
            return "耐心"
        case .encouraging:
            return "鼓励"
        case .wise:
            return "智慧"
        case .playful:
            return "有趣"
        case .curious:
            return "好奇"
        case .helpful:
            return "帮助"
        }
    }
}

/// Character moods that affect appearance and behavior
/// 
/// These moods change based on learning progress and provide
/// visual feedback to children about their performance.
enum CharacterMood: String, CaseIterable, Codable {
    case happy = "happy"
    case excited = "excited"
    case proud = "proud"
    case encouraging = "encouraging"
    case supportive = "supportive"
    case curious = "curious"
    case surprised = "surprised"
    
    /// Returns the display name for the mood
    var displayName: String {
        switch self {
        case .happy:
            return "Happy"
        case .excited:
            return "Excited"
        case .proud:
            return "Proud"
        case .encouraging:
            return "Encouraging"
        case .supportive:
            return "Supportive"
        case .curious:
            return "Curious"
        case .surprised:
            return "Surprised"
        }
    }
    
    /// Returns the Chinese name for the mood
    var chineseName: String {
        switch self {
        case .happy:
            return "开心"
        case .excited:
            return "兴奋"
        case .proud:
            return "骄傲"
        case .encouraging:
            return "鼓励"
        case .supportive:
            return "支持"
        case .curious:
            return "好奇"
        case .surprised:
            return "惊讶"
        }
    }
    
    /// Returns the color associated with this mood
    var color: Color {
        switch self {
        case .happy:
            return .green
        case .excited:
            return .orange
        case .proud:
            return .purple
        case .encouraging:
            return .blue
        case .supportive:
            return .teal
        case .curious:
            return .yellow
        case .surprised:
            return .pink
        }
    }
}

/// Manages all characters in the app
/// 
/// This class provides access to all characters, manages their states,
/// and handles character interactions and animations.
class CharacterManager: ObservableObject {
    /// Shared instance for singleton access
    static let shared = CharacterManager()
    
    /// All characters in the app
    @Published var characters: [AppCharacter] = []
    
    /// The currently active character
    @Published var activeCharacter: AppCharacter?
    
    /// Private initializer for singleton pattern
    private init() {
        loadCharacters()
    }
    
    /// Loads all characters into the app
    /// 
    /// This method creates the main characters including the little dinosaur,
    /// teacher panda, and forest friends as specified in the PRD.
    private func loadCharacters() -> Void {
        characters = [
            // Main Character: 小恐龙 (Little Dinosaur)
            AppCharacter(
                name: "Little Dinosaur",
                chineseName: "小恐龙",
                type: .mainCharacter,
                personality: [.friendly, .curious, .playful, .encouraging],
                color: "green",
                imageFileName: "little_dinosaur"
            ),
            
            // Teacher Panda (熊猫老师)
            AppCharacter(
                name: "Teacher Panda",
                chineseName: "熊猫老师",
                type: .teacher,
                personality: [.wise, .patient, .encouraging, .helpful],
                color: "black",
                imageFileName: "teacher_panda"
            ),
            
            // Forest Friends
            AppCharacter(
                name: "Forest Bird",
                chineseName: "森林鸟",
                type: .friend,
                personality: [.friendly, .helpful, .playful],
                color: "blue",
                imageFileName: "forest_bird"
            ),
            
            AppCharacter(
                name: "Forest Rabbit",
                chineseName: "森林兔",
                type: .friend,
                personality: [.friendly, .curious, .helpful],
                color: "brown",
                imageFileName: "forest_rabbit"
            ),
            
            AppCharacter(
                name: "Forest Fish",
                chineseName: "森林鱼",
                type: .friend,
                personality: [.friendly, .playful, .encouraging],
                color: "orange",
                imageFileName: "forest_fish"
            )
        ]
        
        // Set the little dinosaur as the active character
        activeCharacter = characters.first { $0.type == .mainCharacter }
    }
    
    /// Returns the main character (little dinosaur)
    /// 
    /// - Returns: The main character or nil if not found
    func getMainCharacter() -> AppCharacter? {
        return characters.first { $0.type == .mainCharacter }
    }
    
    /// Returns the teacher character (panda)
    /// 
    /// - Returns: The teacher character or nil if not found
    func getTeacherCharacter() -> AppCharacter? {
        return characters.first { $0.type == .teacher }
    }
    
    /// Returns all friend characters
    /// 
    /// - Returns: Array of friend characters
    func getFriendCharacters() -> [AppCharacter] {
        return characters.filter { $0.type == .friend }
    }
    
    /// Updates the main character's mood based on learning progress
    /// 
    /// - Parameter progress: The current learning progress (0-100)
    func updateMainCharacterMood(progress: Int) -> Void {
        guard let mainCharacter = getMainCharacter() else { return }
        
        let newMood: CharacterMood
        switch progress {
        case 0..<20:
            newMood = .curious
        case 20..<40:
            newMood = .encouraging
        case 40..<60:
            newMood = .supportive
        case 60..<80:
            newMood = .excited
        case 80..<100:
            newMood = .proud
        default:
            newMood = .happy
        }
        
        // Update the character's mood
        if let index = characters.firstIndex(where: { $0.id == mainCharacter.id }) {
            characters[index].currentMood = newMood
            activeCharacter = characters[index]
        }
    }
    
    /// Returns a character by type
    /// 
    /// - Parameter type: The character type to find
    /// - Returns: The character of the specified type or nil if not found
    func getCharacter(by type: CharacterType) -> AppCharacter? {
        return characters.first { $0.type == type }
    }
    
    /// Returns a random friend character
    /// 
    /// - Returns: A randomly selected friend character
    func getRandomFriend() -> AppCharacter? {
        let friends = getFriendCharacters()
        return friends.randomElement()
    }
    
    /// Returns an encouraging message from the active character
    /// 
    /// - Parameter context: The learning context
    /// - Returns: An encouraging message appropriate for the context
    func getEncouragingMessage(for context: LearningContext) -> String {
        guard let character = activeCharacter else {
            return "Great job! 做得好！"
        }
        
        switch context {
        case .correctAnswer:
            return "Excellent! 太棒了！"
        case .incorrectAnswer:
            return "Try again! 再试一次！"
        case .milestoneAchieved:
            return "Congratulations! 恭喜！"
        case .sessionComplete:
            return "Well done! 做得很好！"
        case .newWord:
            return "New word! 新词！"
        }
    }
}

/// Learning contexts for character interactions
/// 
/// These contexts help determine appropriate character responses
/// and messages during different learning situations.
enum LearningContext {
    case correctAnswer
    case incorrectAnswer
    case milestoneAchieved
    case sessionComplete
    case newWord
}
