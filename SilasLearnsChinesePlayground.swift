import SwiftUI
import PlaygroundSupport

// MARK: - Self-Contained Test App
// This file contains everything needed to test the app without external dependencies

// MARK: - Data Models
struct VocabularyWord: Identifiable {
    let id = UUID()
    let chinese: String
    let pinyin: String
    let english: String
    let category: String
}

struct LearningProgress {
    var wordsLearned: Int = 15
    var sessions: Int = 8
    var averageScore: Int = 87
    var streak: Int = 5
}

// MARK: - Simple Test App
struct TestSilasLearnsChineseApp: View {
    @State private var selectedTab = 0
    @State private var isAnimating = false
    @State private var progress = LearningProgress()
    @State private var currentWord = VocabularyWord(
        chinese: "快乐", 
        pinyin: "kuài lè", 
        english: "happy", 
        category: "emotions"
    )
    
    let sampleWords = [
        VocabularyWord(chinese: "红色", pinyin: "hóng sè", english: "red", category: "colors"),
        VocabularyWord(chinese: "蓝色", pinyin: "lán sè", english: "blue", category: "colors"),
        VocabularyWord(chinese: "一", pinyin: "yī", english: "one", category: "numbers"),
        VocabularyWord(chinese: "二", pinyin: "èr", english: "two", category: "numbers"),
        VocabularyWord(chinese: "猫", pinyin: "māo", english: "cat", category: "animals"),
        VocabularyWord(chinese: "恐龙", pinyin: "kǒng lóng", english: "dinosaur", category: "animals")
    ]
    
    var body: some View {
        ZStack {
            // Studio Ghibli Background
            GhibliBackground()
            
            TabView(selection: $selectedTab) {
                // Home Tab
                HomeTestView(progress: progress)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)
                
                // Learning Tab
                LearningTestView(currentWord: currentWord, words: sampleWords)
                    .tabItem {
                        Image(systemName: "book.fill")
                        Text("Learn")
                    }
                    .tag(1)
                
                // Activities Tab
                ActivitiesTestView()
                    .tabItem {
                        Image(systemName: "gamecontroller.fill")
                        Text("Play")
                    }
                    .tag(2)
                
                // Progress Tab
                ProgressTestView(progress: progress)
                    .tabItem {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                        Text("Progress")
                    }
                    .tag(3)
            }
            .accentColor(Color(red: 0.2, green: 0.6, blue: 0.4))
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}

// MARK: - Studio Ghibli Background
struct GhibliBackground: View {
    @State private var cloudOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            // Base gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.85, green: 0.92, blue: 0.88), // Soft mint
                    Color(red: 0.78, green: 0.88, blue: 0.82), // Sage green
                    Color(red: 0.72, green: 0.84, blue: 0.78)  // Forest green
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Floating clouds
            ForEach(0..<3) { index in
                CloudShape()
                    .fill(Color.white.opacity(0.6))
                    .frame(width: 60, height: 30)
                    .offset(x: cloudOffset + CGFloat(index * 200), y: CGFloat(index * 50))
            }
            
            // Floating leaves
            ForEach(0..<5) { index in
                LeafShape()
                    .fill(Color.green.opacity(0.4))
                    .frame(width: 20, height: 30)
                    .offset(x: CGFloat(index * 80), y: CGFloat(index * 100))
                    .rotationEffect(.degrees(Double(index * 30)))
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
                cloudOffset = -400
            }
        }
    }
}

// MARK: - Simple Shapes
struct CloudShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: CGRect(x: 0, y: 10, width: 20, height: 20))
        path.addEllipse(in: CGRect(x: 15, y: 5, width: 25, height: 25))
        path.addEllipse(in: CGRect(x: 35, y: 10, width: 20, height: 20))
        return path
    }
}

struct LeafShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY), 
                         control: CGPoint(x: rect.maxX, y: rect.midY))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.minY), 
                         control: CGPoint(x: rect.minX, y: rect.midY))
        return path
    }
}

// MARK: - Home Test View
struct HomeTestView: View {
    let progress: LearningProgress
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 10) {
                    Text("🦕 小恐龙学中文")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("Silas Learns Chinese")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)
                
                // Character
                DinosaurCharacterView()
                
                // Quick Stats
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 15) {
                    QuickStatCard(title: "Words", value: "\(progress.wordsLearned)", color: .blue)
                    QuickStatCard(title: "Streak", value: "\(progress.streak) days", color: .orange)
                }
                
                // Quick Actions
                VStack(spacing: 15) {
                    Text("Quick Actions")
                        .font(.headline)
                        .padding(.top)
                    
                    QuickActionButton(title: "Practice Words", icon: "book.fill", color: .green)
                    QuickActionButton(title: "Play Games", icon: "gamecontroller.fill", color: .purple)
                    QuickActionButton(title: "Voice Practice", icon: "mic.fill", color: .red)
                }
            }
            .padding()
        }
    }
}

// MARK: - Learning Test View
struct LearningTestView: View {
    let currentWord: VocabularyWord
    let words: [VocabularyWord]
    @State private var selectedCategory = 0
    
    let categories = ["Colors", "Numbers", "Animals", "Body Parts", "Food"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Category Selector
                    VStack(spacing: 15) {
                        Text("Choose Category")
                            .font(.headline)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(0..<categories.count, id: \.self) { index in
                                    CategoryCard(
                                        category: categories[index], 
                                        isSelected: selectedCategory == index
                                    )
                                    .onTapGesture {
                                        selectedCategory = index
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Word of the Day
                    WordOfDayCard(word: currentWord)
                    
                    // Voice Recognition
                    VoiceRecognitionCard()
                    
                    // Quick Practice
                    QuickPracticeCard()
                    
                    // Word List
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 15) {
                        ForEach(words) { word in
                            WordCard(word: word)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Learning Center")
        }
    }
}

// MARK: - Activities Test View
struct ActivitiesTestView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Fun Activities!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                    ActivityCard(title: "Memory Game", icon: "brain.head.profile", color: .purple)
                    ActivityCard(title: "Coloring", icon: "paintbrush.fill", color: .pink)
                    ActivityCard(title: "Matching", icon: "square.on.square", color: .blue)
                    ActivityCard(title: "Drawing", icon: "pencil.tip.crop.circle", color: .orange)
                    ActivityCard(title: "Singing", icon: "music.note", color: .green)
                    ActivityCard(title: "Stories", icon: "book.closed.fill", color: .red)
                }
                .padding()
            }
        }
    }
}

// MARK: - Progress Test View
struct ProgressTestView: View {
    let progress: LearningProgress
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Your Progress")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                // Stats
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                    StatCard(title: "Words Learned", value: "\(progress.wordsLearned)", icon: "book.fill", color: .blue)
                    StatCard(title: "Sessions", value: "\(progress.sessions)", icon: "play.fill", color: .green)
                    StatCard(title: "Average Score", value: "\(progress.averageScore)%", icon: "star.fill", color: .orange)
                    StatCard(title: "Streak", value: "\(progress.streak) days", icon: "flame.fill", color: .red)
                }
                
                // Progress Chart
                ProgressChartView(progress: progress)
                
                // Achievements
                AchievementsView()
            }
            .padding()
        }
    }
}

// MARK: - UI Components
struct DinosaurCharacterView: View {
    @State private var isHappy = true
    
    var body: some View {
        VStack {
            Text("🦕")
                .font(.system(size: 80))
                .scaleEffect(isHappy ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isHappy)
            
            Text("Hi Silas! 你好!")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.primary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.8))
                .shadow(radius: 5)
        )
        .onAppear {
            isHappy.toggle()
        }
    }
}

struct QuickStatCard: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(height: 80)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(color.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(color.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

struct QuickActionButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.8))
                .shadow(radius: 2)
        )
    }
}

struct CategoryCard: View {
    let category: String
    let isSelected: Bool
    
    var body: some View {
        Text(category)
            .font(.caption)
            .fontWeight(.medium)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? Color.blue : Color.gray.opacity(0.2))
            )
            .foregroundColor(isSelected ? .white : .primary)
    }
}

struct WordOfDayCard: View {
    let word: VocabularyWord
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Word of the Day")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text(word.chinese)
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.primary)
            
            Text(word.pinyin)
                .font(.title2)
                .foregroundColor(.blue)
            
            Text(word.english)
                .font(.title3)
                .foregroundColor(.secondary)
            
            Button("🔊 Play Sound") {
                // Audio would play here
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.green)
            .cornerRadius(10)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.9))
                .shadow(radius: 5)
        )
    }
}

struct VoiceRecognitionCard: View {
    @State private var isListening = false
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Voice Practice")
                .font(.headline)
            
            Button(action: {
                isListening.toggle()
            }) {
                Image(systemName: isListening ? "mic.fill" : "mic")
                    .font(.system(size: 40))
                    .foregroundColor(isListening ? .red : .blue)
                    .scaleEffect(isListening ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isListening)
            }
            
            Text(isListening ? "Listening..." : "Tap to Practice")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.blue.opacity(0.1))
        )
    }
}

struct QuickPracticeCard: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Quick Practice")
                .font(.headline)
            
            HStack(spacing: 15) {
                PracticeButton(title: "Flashcards", icon: "rectangle.stack.fill", color: .purple)
                PracticeButton(title: "Quiz", icon: "questionmark.circle.fill", color: .orange)
                PracticeButton(title: "Writing", icon: "pencil", color: .green)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.1))
        )
    }
}

struct PracticeButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(color.opacity(0.1))
        )
    }
}

struct WordCard: View {
    let word: VocabularyWord
    
    var body: some View {
        VStack(spacing: 8) {
            Text(word.chinese)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(word.pinyin)
                .font(.caption)
                .foregroundColor(.blue)
            
            Text(word.english)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.8))
                .shadow(radius: 2)
        )
    }
}

struct ActivityCard: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(color)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .frame(height: 120)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(color.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(color.opacity(0.3), lineWidth: 2)
                )
        )
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(color.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(color.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

struct ProgressChartView: View {
    let progress: LearningProgress
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Learning Progress")
                .font(.headline)
            
            HStack(spacing: 15) {
                ForEach(1...7, id: \.self) { day in
                    VStack {
                        Rectangle()
                            .fill(day <= progress.streak ? Color.green : Color.gray.opacity(0.3))
                            .frame(width: 20, height: CGFloat.random(in: 30...80))
                            .cornerRadius(10)
                        
                        Text("D\(day)")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.8))
        )
    }
}

struct AchievementsView: View {
    let achievements = [
        "🎯 First Word",
        "🔥 5 Day Streak",
        "📚 10 Words Learned",
        "⭐ Perfect Score"
    ]
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Achievements")
                .font(.headline)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                ForEach(achievements, id: \.self) { achievement in
                    Text(achievement)
                        .font(.caption)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.yellow.opacity(0.2))
                        )
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.8))
        )
    }
}

// MARK: - Playground Setup
let testApp = TestSilasLearnsChineseApp()
PlaygroundPage.current.setLiveView(testApp)
