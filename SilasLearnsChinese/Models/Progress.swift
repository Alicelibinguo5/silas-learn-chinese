import Foundation
import Combine

/// Represents a learning milestone or achievement
/// 
/// This model tracks specific accomplishments in the learning journey,
/// such as completing a category or reaching a certain number of words learned.
struct LearningMilestone: Identifiable, Codable {
    /// Unique identifier for the milestone
    let id: UUID
    /// The type of milestone achieved
    let type: MilestoneType
    /// The date when the milestone was achieved
    let achievedDate: Date
    /// Additional data associated with the milestone
    let data: [String: String]
    
    /// Initializes a new learning milestone
    /// 
    /// - Parameters:
    ///   - type: The type of milestone
    ///   - data: Additional data for the milestone
    init(type: MilestoneType, data: [String: String] = [:]) {
        self.id = UUID()
        self.type = type
        self.achievedDate = Date()
        self.data = data
    }
}

/// Types of learning milestones that can be achieved
/// 
/// These milestone types correspond to different learning achievements
/// and help track progress through the app.
enum MilestoneType: String, CaseIterable, Codable {
    case firstWord = "firstWord"
    case categoryComplete = "categoryComplete"
    case tenWords = "tenWords"
    case twentyWords = "twentyWords"
    case perfectScore = "perfectScore"
    case dailyStreak = "dailyStreak"
    case weeklyStreak = "weeklyStreak"
    
    /// Returns the display name for the milestone
    var displayName: String {
        switch self {
        case .firstWord:
            return "First Word Learned"
        case .categoryComplete:
            return "Category Complete"
        case .tenWords:
            return "10 Words Mastered"
        case .twentyWords:
            return "20 Words Mastered"
        case .perfectScore:
            return "Perfect Score"
        case .dailyStreak:
            return "Daily Learning Streak"
        case .weeklyStreak:
            return "Weekly Learning Streak"
        }
    }
    
    /// Returns the Chinese name for the milestone
    var chineseName: String {
        switch self {
        case .firstWord:
            return "第一个词"
        case .categoryComplete:
            return "类别完成"
        case .tenWords:
            return "十个词"
        case .twentyWords:
            return "二十个词"
        case .perfectScore:
            return "完美分数"
        case .dailyStreak:
            return "每日学习"
        case .weeklyStreak:
            return "每周学习"
        }
    }
}

/// Type of learning session
/// 
/// This enum categorizes different types of learning activities
/// to help track and analyze learning patterns.
enum LearningSessionType: String, Codable, CaseIterable {
    case vocabulary = "vocabulary"
    case pronunciation = "pronunciation"
    case writing = "writing"
    case listening = "listening"
    case games = "games"
    case review = "review"
    case quiz = "quiz"
    case freePlay = "free_play"
    
    /// Localized display name for the session type
    var displayName: String {
        switch self {
        case .vocabulary:
            return "Vocabulary Practice"
        case .pronunciation:
            return "Pronunciation Practice"
        case .writing:
            return "Writing Practice"
        case .listening:
            return "Listening Practice"
        case .games:
            return "Learning Games"
        case .review:
            return "Review Session"
        case .quiz:
            return "Quiz"
        case .freePlay:
            return "Free Play"
        }
    }
    
    /// Chinese translation of the session type
    var chineseName: String {
        switch self {
        case .vocabulary:
            return "词汇练习"
        case .pronunciation:
            return "发音练习"
        case .writing:
            return "写字练习"
        case .listening:
            return "听力练习"
        case .games:
            return "学习游戏"
        case .review:
            return "复习"
        case .quiz:
            return "测验"
        case .freePlay:
            return "自由学习"
        }
    }
}

/// Represents a learning session with results
/// 
/// This model tracks individual learning sessions including
/// the words studied, scores achieved, and time spent.
struct LearningSession: Identifiable, Codable {
    /// Unique identifier for the session
    let id: UUID
    /// The date and time of the session
    let date: Date
    /// The type of learning session
    let sessionType: LearningSessionType
    /// The vocabulary words studied in this session
    let wordsStudied: [String]
    /// The score achieved (0-100)
    let score: Int
    /// Time spent in the session (in seconds)
    let duration: TimeInterval
    /// Whether the session was completed
    let completed: Bool
    
    /// Initializes a new learning session
    /// 
    /// - Parameters:
    ///   - sessionType: The type of learning session
    ///   - wordsStudied: The words studied in the session
    ///   - score: The score achieved
    ///   - duration: The time spent in the session
    ///   - completed: Whether the session was completed
    init(sessionType: LearningSessionType, wordsStudied: [String], score: Int, duration: TimeInterval, completed: Bool) {
        self.id = UUID()
        self.date = Date()
        self.sessionType = sessionType
        self.wordsStudied = wordsStudied
        self.score = score
        self.duration = duration
        self.completed = completed
    }
}

/// Manages user progress and learning achievements
/// 
/// This class tracks learning progress, manages milestones,
/// and provides insights into the user's learning journey.
class ProgressManager: ObservableObject {
    /// Shared instance for singleton access
    static let shared = ProgressManager()
    
    /// All learning sessions
    @Published var sessions: [LearningSession] = []
    
    /// All achieved milestones
    @Published var milestones: [LearningMilestone] = []
    
    /// Words that have been learned (with mastery level)
    @Published var learnedWords: [String: WordMastery] = [:]
    
    /// Current learning streak (consecutive days)
    @Published var currentStreak: Int = 0
    
    /// Longest learning streak achieved
    @Published var longestStreak: Int = 0
    
    /// Total time spent learning
    @Published var totalLearningTime: TimeInterval = 0
    
    /// Private initializer for singleton pattern
    private init() {
        loadProgress()
    }
    
    /// Loads saved progress from local storage
    /// 
    /// This method retrieves progress data from UserDefaults
    /// and restores the learning state.
    func loadProgress() -> Void {
        // Load sessions
        if let sessionsData = UserDefaults.standard.data(forKey: "learningSessions"),
           let sessions = try? JSONDecoder().decode([LearningSession].self, from: sessionsData) {
            self.sessions = sessions
        }
        
        // Load milestones
        if let milestonesData = UserDefaults.standard.data(forKey: "milestones"),
           let milestones = try? JSONDecoder().decode([LearningMilestone].self, from: milestonesData) {
            self.milestones = milestones
        }
        
        // Load learned words
        if let learnedWordsData = UserDefaults.standard.data(forKey: "learnedWords"),
           let learnedWords = try? JSONDecoder().decode([String: WordMastery].self, from: learnedWordsData) {
            self.learnedWords = learnedWords
        }
        
        // Load streaks
        self.currentStreak = UserDefaults.standard.integer(forKey: "currentStreak")
        self.longestStreak = UserDefaults.standard.integer(forKey: "longestStreak")
        self.totalLearningTime = UserDefaults.standard.double(forKey: "totalLearningTime")
    }
    
    /// Saves progress to local storage
    /// 
    /// This method persists progress data to UserDefaults
    /// to maintain learning state across app launches.
    func saveProgress() -> Void {
        // Save sessions
        if let sessionsData = try? JSONEncoder().encode(sessions) {
            UserDefaults.standard.set(sessionsData, forKey: "learningSessions")
        }
        
        // Save milestones
        if let milestonesData = try? JSONEncoder().encode(milestones) {
            UserDefaults.standard.set(milestonesData, forKey: "milestones")
        }
        
        // Save learned words
        if let learnedWordsData = try? JSONEncoder().encode(learnedWords) {
            UserDefaults.standard.set(learnedWordsData, forKey: "learnedWords")
        }
        
        // Save streaks
        UserDefaults.standard.set(currentStreak, forKey: "currentStreak")
        UserDefaults.standard.set(longestStreak, forKey: "longestStreak")
        UserDefaults.standard.set(totalLearningTime, forKey: "totalLearningTime")
    }
    
    /// Records a new learning session
    /// 
    /// - Parameter session: The learning session to record
    func recordSession(_ session: LearningSession) -> Void {
        sessions.append(session)
        totalLearningTime += session.duration
        
        // Update streaks
        updateStreaks()
        
        // Check for milestones
        checkMilestones()
        
        // Save progress
        saveProgress()
    }
    
    /// Marks a word as learned with a mastery level
    /// 
    /// - Parameters:
    ///   - word: The Chinese word to mark as learned
    ///   - masteryLevel: The mastery level achieved
    func markWordAsLearned(_ word: String, masteryLevel: WordMastery) -> Void {
        learnedWords[word] = masteryLevel
        
        // Check for milestones
        checkMilestones()
        
        // Save progress
        saveProgress()
    }
    
    /// Updates learning streaks based on recent activity
    /// 
    /// This method checks if the user has been learning consistently
    /// and updates streak counters accordingly.
    private func updateStreaks() -> Void {
        let calendar = Calendar.current
        let today = Date()
        
        // Check if user learned today
        let todaySessions = sessions.filter { session in
            calendar.isDate(session.date, inSameDayAs: today)
        }
        
        if !todaySessions.isEmpty {
            currentStreak += 1
            if currentStreak > longestStreak {
                longestStreak = currentStreak
            }
        } else {
            // Check if user learned yesterday (for streak continuation)
            let yesterday = calendar.date(byAdding: .day, value: -1, to: today) ?? today
            let yesterdaySessions = sessions.filter { session in
                calendar.isDate(session.date, inSameDayAs: yesterday)
            }
            
            if yesterdaySessions.isEmpty {
                currentStreak = 0
            }
        }
    }
    
    /// Checks for new milestones based on current progress
    /// 
    /// This method evaluates current progress and creates new milestones
    /// when appropriate achievements are reached.
    private func checkMilestones() -> Void {
        // Check for first word milestone
        if learnedWords.count == 1 && !milestones.contains(where: { $0.type == .firstWord }) {
            let milestone = LearningMilestone(type: .firstWord)
            milestones.append(milestone)
        }
        
        // Check for word count milestones
        if learnedWords.count >= 10 && !milestones.contains(where: { $0.type == .tenWords }) {
            let milestone = LearningMilestone(type: .tenWords)
            milestones.append(milestone)
        }
        
        if learnedWords.count >= 20 && !milestones.contains(where: { $0.type == .twentyWords }) {
            let milestone = LearningMilestone(type: .twentyWords)
            milestones.append(milestone)
        }
        
        // Check for perfect score milestone
        let perfectSessions = sessions.filter { $0.score == 100 }
        if !perfectSessions.isEmpty && !milestones.contains(where: { $0.type == .perfectScore }) {
            let milestone = LearningMilestone(type: .perfectScore)
            milestones.append(milestone)
        }
        
        // Check for streak milestones
        if currentStreak >= 7 && !milestones.contains(where: { $0.type == .weeklyStreak }) {
            let milestone = LearningMilestone(type: .weeklyStreak)
            milestones.append(milestone)
        }
    }
    
    /// Returns the total number of words learned
    /// 
    /// - Returns: The count of learned words
    func totalWordsLearned() -> Int {
        return learnedWords.count
    }
    
    /// Returns the average score across all sessions
    /// 
    /// - Returns: The average score (0-100)
    func averageScore() -> Double {
        guard !sessions.isEmpty else { return 0 }
        let totalScore = sessions.reduce(0) { $0 + $1.score }
        return Double(totalScore) / Double(sessions.count)
    }
    
    /// Returns the total number of sessions completed
    /// 
    /// - Returns: The count of completed sessions
    func totalSessions() -> Int {
        return sessions.filter { $0.completed }.count
    }
}

/// Represents the mastery level of a learned word
/// 
/// This enum tracks how well a word has been learned,
/// from initial exposure to full mastery.
enum WordMastery: Int, Codable, CaseIterable {
    case exposed = 1
    case familiar = 2
    case practiced = 3
    case mastered = 4
    
    /// Returns the display name for the mastery level
    var displayName: String {
        switch self {
        case .exposed:
            return "Exposed"
        case .familiar:
            return "Familiar"
        case .practiced:
            return "Practiced"
        case .mastered:
            return "Mastered"
        }
    }
    
    /// Returns the Chinese name for the mastery level
    var chineseName: String {
        switch self {
        case .exposed:
            return "接触过"
        case .familiar:
            return "熟悉"
        case .practiced:
            return "练习过"
        case .mastered:
            return "掌握"
        }
    }
}
