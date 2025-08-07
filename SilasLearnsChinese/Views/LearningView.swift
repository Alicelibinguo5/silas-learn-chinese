import SwiftUI
import AVFoundation

struct LearningView: View {
    @State private var selectedCategory = 0
    @State private var showingVoiceRecognition = false
    @State private var currentWord: VocabularyWord?
    @State private var isPlayingAudio = false
    
    let categories = ["Colors", "Numbers", "Animals", "Body Parts", "Food", "Emotions", "Family", "Weather"]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.85, green: 0.92, blue: 0.88),
                        Color(red: 0.78, green: 0.88, blue: 0.82)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        // Category selector
                        CategorySelector(selectedCategory: $selectedCategory, categories: categories)
                        
                        // Voice recognition feature
                        VoiceRecognitionCard(showingVoiceRecognition: $showingVoiceRecognition)
                        
                        // Word of the day
                        WordOfTheDayCard(currentWord: $currentWord, isPlayingAudio: $isPlayingAudio)
                        
                        // Learning progress
                        LearningProgressCard()
                        
                        // Quick practice
                        QuickPracticeCard()
                        
                        // Advanced features
                        AdvancedFeaturesCard()
                    }
                    .padding()
                }
            }
            .navigationTitle("Learning Center")
            .navigationBarTitleDisplayMode(.large)
        }
        .sheet(isPresented: $showingVoiceRecognition) {
            VoiceRecognitionView()
        }
    }
}

// MARK: - Category Selector
struct CategorySelector: View {
    @Binding var selectedCategory: Int
    let categories: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Choose a Category")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(0..<categories.count, id: \.self) { index in
                        CategoryCard(
                            title: categories[index],
                            isSelected: selectedCategory == index,
                            icon: getIcon(for: categories[index]),
                            color: getColor(for: categories[index])
                        )
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedCategory = index
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 8)
        )
    }
    
    private func getIcon(for category: String) -> String {
        switch category {
        case "Colors": return "paintpalette.fill"
        case "Numbers": return "number.circle.fill"
        case "Animals": return "pawprint.fill"
        case "Body Parts": return "person.fill"
        case "Food": return "leaf.fill"
        case "Emotions": return "heart.fill"
        case "Family": return "house.fill"
        case "Weather": return "cloud.sun.fill"
        default: return "book.fill"
        }
    }
    
    private func getColor(for category: String) -> Color {
        switch category {
        case "Colors": return .purple
        case "Numbers": return .orange
        case "Animals": return .green
        case "Body Parts": return .blue
        case "Food": return .brown
        case "Emotions": return .pink
        case "Family": return .red
        case "Weather": return .cyan
        default: return .gray
        }
    }
}

struct CategoryCard: View {
    let title: String
    let isSelected: Bool
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(isSelected ? .white : color)
            
            Text(title)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundColor(isSelected ? .white : .primary)
                .multilineTextAlignment(.center)
        }
        .frame(width: 80, height: 80)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(isSelected ? color : Color.white.opacity(0.8))
                .shadow(color: isSelected ? color.opacity(0.3) : Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .scaleEffect(isSelected ? 1.1 : 1.0)
        .animation(.spring(), value: isSelected)
    }
}

// MARK: - Voice Recognition Card
struct VoiceRecognitionCard: View {
    @Binding var showingVoiceRecognition: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: "mic.fill")
                    .font(.title2)
                    .foregroundColor(.blue)
                
                Text("Voice Recognition")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text("NEW")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.orange)
                    )
            }
            
            Text("Practice pronunciation with voice recognition technology")
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(.secondary)
            
            Button(action: {
                showingVoiceRecognition = true
            }) {
                HStack {
                    Image(systemName: "play.fill")
                    Text("Start Voice Practice")
                }
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.blue)
                )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
    }
}

// MARK: - Word of the Day Card
struct WordOfTheDayCard: View {
    @Binding var currentWord: VocabularyWord?
    @Binding var isPlayingAudio: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Word of the Day")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            
            HStack(spacing: 20) {
                // Word display
                VStack(alignment: .leading, spacing: 8) {
                    Text("快乐")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
                    
                    Text("kuài lè")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                    
                    Text("Happy")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                // Audio button
                Button(action: {
                    playAudio()
                }) {
                    Image(systemName: isPlayingAudio ? "stop.fill" : "play.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(
                            Circle()
                                .fill(isPlayingAudio ? Color.red : Color.green)
                        )
                }
            }
            
            Text("Practice saying '快乐' (Happy) with a big smile!")
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(.secondary)
                .padding(.top, 5)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
    }
    
    private func playAudio() {
        isPlayingAudio.toggle()
        // Simulate audio playback
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isPlayingAudio = false
        }
    }
}

// MARK: - Learning Progress Card
struct LearningProgressCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Your Learning Progress")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            
            VStack(spacing: 12) {
                ProgressRow(title: "Words Mastered", progress: 0.8, color: .green)
                ProgressRow(title: "Perfect Pronunciations", progress: 0.6, color: .blue)
                ProgressRow(title: "Learning Streak", progress: 0.9, color: .orange)
                ProgressRow(title: "New Categories", progress: 0.4, color: .purple)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
    }
}

struct ProgressRow: View {
    let title: String
    let progress: Double
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(title)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text("\(Int(progress * 100))%")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundColor(color)
            }
            
            ProgressView(value: progress, total: 1.0)
                .progressViewStyle(LinearProgressViewStyle(tint: color))
                .scaleEffect(x: 1, y: 2, anchor: .center)
        }
    }
}

// MARK: - Quick Practice Card
struct QuickPracticeCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Quick Practice")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 15) {
                PracticeButton(title: "Flashcards", icon: "rectangle.on.rectangle", color: .blue)
                PracticeButton(title: "Quiz Mode", icon: "questionmark.circle", color: .green)
                PracticeButton(title: "Writing", icon: "pencil", color: .orange)
                PracticeButton(title: "Listening", icon: "ear", color: .purple)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
    }
}

struct PracticeButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(title)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
        }
        .frame(height: 70)
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.8))
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
    }
}

// MARK: - Advanced Features Card
struct AdvancedFeaturesCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Advanced Features")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            
            VStack(spacing: 12) {
                FeatureRow(title: "Sentence Building", description: "Learn to form simple sentences", icon: "text.bubble", color: .blue)
                FeatureRow(title: "Cultural Stories", description: "Discover Chinese culture through stories", icon: "book.closed", color: .green)
                FeatureRow(title: "Character Writing", description: "Learn to write Chinese characters", icon: "pencil.and.outline", color: .orange)
                FeatureRow(title: "Conversation Practice", description: "Practice real conversations", icon: "message", color: .purple)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
    }
}

struct FeatureRow: View {
    let title: String
    let description: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary)
                
                Text(description)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.6))
        )
    }
}

// MARK: - Voice Recognition View
struct VoiceRecognitionView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isListening = false
    @State private var recognizedText = ""
    @State private var targetWord = "快乐"
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.85, green: 0.92, blue: 0.88),
                        Color(red: 0.78, green: 0.88, blue: 0.82)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    // Target word
                    VStack(spacing: 15) {
                        Text("Say this word:")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                        
                        Text(targetWord)
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
                        
                        Text("kuài lè (Happy)")
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                    }
                    
                    // Recognition result
                    VStack(spacing: 10) {
                        Text("You said:")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                        
                        Text(recognizedText.isEmpty ? "..." : recognizedText)
                            .font(.system(size: 24, weight: .semibold, design: .rounded))
                            .foregroundColor(.primary)
                            .frame(minHeight: 40)
                    }
                    
                    // Microphone button
                    Button(action: {
                        toggleListening()
                    }) {
                        ZStack {
                            Circle()
                                .fill(isListening ? Color.red : Color.blue)
                                .frame(width: 120, height: 120)
                                .shadow(color: isListening ? Color.red.opacity(0.3) : Color.blue.opacity(0.3), radius: 15, x: 0, y: 8)
                            
                            Image(systemName: isListening ? "stop.fill" : "mic.fill")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(.white)
                        }
                    }
                    .scaleEffect(isListening ? 1.1 : 1.0)
                    .animation(.spring(), value: isListening)
                    
                    // Feedback
                    if !recognizedText.isEmpty {
                        VStack(spacing: 10) {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text("Great pronunciation!")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundColor(.green)
                            }
                            
                            Text("Try saying it again for practice")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Voice Practice")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func toggleListening() {
        isListening.toggle()
        
        if isListening {
            // Simulate voice recognition
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                recognizedText = "快乐"
                isListening = false
            }
        } else {
            recognizedText = ""
        }
    }
}

// MARK: - Vocabulary Word Model
struct VocabularyWord {
    let chinese: String
    let pinyin: String
    let english: String
    let category: String
    let audioURL: String?
}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView()
    }
}
