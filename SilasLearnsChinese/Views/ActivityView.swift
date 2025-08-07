import SwiftUI

/// Activity view for additional learning games and activities
/// 
/// This view provides supplementary learning activities beyond
/// the core vocabulary learning, including games and interactive
/// experiences designed to reinforce learning.
struct ActivityView: View {
    /// Current activity selection
    @State private var selectedActivity: ActivityType = .coloring
    /// Whether an activity is currently active
    @State private var isActivityActive: Bool = false
    
    /// Audio service for sound effects
    @StateObject private var audioService = AudioService.shared
    /// Character manager for character interactions
    @StateObject private var characterManager = CharacterManager.shared
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            VStack(spacing: 10) {
                Text("Fun Activities!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("Let's play and learn!")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Activity selection
            if !isActivityActive {
                ActivitySelectionView(
                    selectedActivity: $selectedActivity,
                    onActivitySelected: {
                        isActivityActive = true
                        audioService.playClickSound()
                    }
                )
            } else {
                // Activity content
                switch selectedActivity {
                case .coloring:
                    ColoringActivityView(
                        onBack: {
                            isActivityActive = false
                            audioService.playClickSound()
                        }
                    )
                case .puzzle:
                    PuzzleActivityView(
                        onBack: {
                            isActivityActive = false
                            audioService.playClickSound()
                        }
                    )
                case .story:
                    StoryActivityView(
                        onBack: {
                            isActivityActive = false
                            audioService.playClickSound()
                        }
                    )
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

/// Types of activities available in the app
/// 
/// These activity types provide different ways for children
/// to engage with Chinese learning beyond vocabulary.
enum ActivityType: String, CaseIterable {
    case coloring = "coloring"
    case puzzle = "puzzle"
    case story = "story"
    
    /// Returns the display name for the activity
    var displayName: String {
        switch self {
        case .coloring:
            return "Coloring"
        case .puzzle:
            return "Puzzle"
        case .story:
            return "Story"
        }
    }
    
    /// Returns the Chinese name for the activity
    var chineseName: String {
        switch self {
        case .coloring:
            return "涂色"
        case .puzzle:
            return "拼图"
        case .story:
            return "故事"
        }
    }
    
    /// Returns the icon for the activity
    var icon: String {
        switch self {
        case .coloring:
            return "paintbrush.fill"
        case .puzzle:
            return "puzzlepiece.fill"
        case .story:
            return "book.fill"
        }
    }
    
    /// Returns the color for the activity
    var color: Color {
        switch self {
        case .coloring:
            return .orange
        case .puzzle:
            return .blue
        case .story:
            return .purple
        }
    }
}

/// Activity selection view
/// 
/// This view displays available activities for children to choose from,
/// with attractive cards and clear descriptions.
struct ActivitySelectionView: View {
    /// Binding to selected activity
    @Binding var selectedActivity: ActivityType
    /// Action when activity is selected
    let onActivitySelected: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Choose an Activity")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                ForEach(ActivityType.allCases, id: \.self) { activity in
                    ActivityCardView(
                        activity: activity,
                        isSelected: selectedActivity == activity,
                        onTap: {
                            selectedActivity = activity
                            onActivitySelected()
                        }
                    )
                }
            }
        }
    }
}

/// Activity card view
/// 
/// This view displays individual activity options with
/// attractive design and clear visual hierarchy.
struct ActivityCardView: View {
    /// The activity to display
    let activity: ActivityType
    /// Whether this activity is selected
    let isSelected: Bool
    /// Action when card is tapped
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 15) {
                // Activity icon
                ZStack {
                    Circle()
                        .fill(activity.color.opacity(0.2))
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: activity.icon)
                        .font(.title)
                        .foregroundColor(activity.color)
                }
                
                // Activity name
                VStack(spacing: 5) {
                    Text(activity.displayName)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text(activity.chineseName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(isSelected ? activity.color : Color.clear, lineWidth: 3)
                    )
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

/// Coloring activity view
/// 
/// This view allows children to color dinosaurs while learning
/// color names in Chinese, as specified in the PRD.
struct ColoringActivityView: View {
    /// Action to go back
    let onBack: () -> Void
    
    /// Current selected color
    @State private var selectedColor: Color = .red
    /// Current dinosaur part to color
    @State private var currentPart: DinosaurPart = .body
    /// Whether coloring is complete
    @State private var isComplete: Bool = false
    
    /// Audio service for sound effects
    @StateObject private var audioService = AudioService.shared
    /// Character manager for character interactions
    @StateObject private var characterManager = CharacterManager.shared
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Button(action: onBack) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.primary)
                }
                
                Spacer()
                
                Text("Dinosaur Coloring")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            if !isComplete {
                // Coloring interface
                VStack(spacing: 30) {
                    // Instruction
                    VStack(spacing: 10) {
                        Text("Color the dinosaur!")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Text("Learn colors in Chinese")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    // Dinosaur coloring area
                    DinosaurColoringView(
                        selectedColor: $selectedColor,
                        currentPart: $currentPart
                    )
                    
                    // Color palette
                    ColorPaletteView(
                        selectedColor: $selectedColor,
                        onColorSelected: { color in
                            selectedColor = color
                            audioService.playClickSound()
                        }
                    )
                    
                    // Part selection
                    DinosaurPartSelector(
                        currentPart: $currentPart,
                        onPartSelected: { part in
                            currentPart = part
                            audioService.playClickSound()
                        }
                    )
                }
            } else {
                // Completion view
                ColoringCompleteView(
                    onContinue: {
                        isComplete = false
                        audioService.playCelebrationSound()
                    }
                )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white.opacity(0.9))
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
    }
}

/// Dinosaur parts for coloring activity
/// 
/// These parts correspond to different areas of the dinosaur
/// that children can color while learning.
enum DinosaurPart: String, CaseIterable {
    case body = "body"
    case head = "head"
    case tail = "tail"
    case legs = "legs"
    
    /// Returns the display name for the part
    var displayName: String {
        switch self {
        case .body:
            return "Body"
        case .head:
            return "Head"
        case .tail:
            return "Tail"
        case .legs:
            return "Legs"
        }
    }
    
    /// Returns the Chinese name for the part
    var chineseName: String {
        switch self {
        case .body:
            return "身体"
        case .head:
            return "头"
        case .tail:
            return "尾巴"
        case .legs:
            return "腿"
        }
    }
}

/// Dinosaur coloring view
/// 
/// This view displays a simple dinosaur shape that children
/// can color by tapping on different parts.
struct DinosaurColoringView: View {
    /// Binding to selected color
    @Binding var selectedColor: Color
    /// Binding to current part
    @Binding var currentPart: DinosaurPart
    
    /// Colors for each part
    @State private var partColors: [DinosaurPart: Color] = [:]
    
    var body: some View {
        ZStack {
            // Dinosaur shape (simplified for MVP)
            VStack(spacing: 0) {
                // Head
                Circle()
                    .fill(partColors[.head] ?? Color.gray.opacity(0.3))
                    .frame(width: 80, height: 80)
                    .onTapGesture {
                        partColors[.head] = selectedColor
                    }
                
                // Body
                RoundedRectangle(cornerRadius: 20)
                    .fill(partColors[.body] ?? Color.gray.opacity(0.3))
                    .frame(width: 120, height: 100)
                    .onTapGesture {
                        partColors[.body] = selectedColor
                    }
                
                // Legs
                HStack(spacing: 20) {
                    ForEach(0..<2) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(partColors[.legs] ?? Color.gray.opacity(0.3))
                            .frame(width: 20, height: 60)
                            .onTapGesture {
                                partColors[.legs] = selectedColor
                            }
                    }
                }
                
                // Tail
                RoundedRectangle(cornerRadius: 10)
                    .fill(partColors[.tail] ?? Color.gray.opacity(0.3))
                    .frame(width: 60, height: 20)
                    .onTapGesture {
                        partColors[.tail] = selectedColor
                    }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.8))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
}

/// Color palette view
/// 
/// This view displays available colors for the coloring activity
/// with Chinese color names for learning.
struct ColorPaletteView: View {
    /// Binding to selected color
    @Binding var selectedColor: Color
    /// Action when color is selected
    let onColorSelected: (Color) -> Void
    
    /// Available colors with Chinese names
    private let colors: [(color: Color, name: String, chineseName: String)] = [
        (.red, "Red", "红色"),
        (.blue, "Blue", "蓝色"),
        (.green, "Green", "绿色"),
        (.yellow, "Yellow", "黄色"),
        (.orange, "Orange", "橙色"),
        (.purple, "Purple", "紫色"),
        (.pink, "Pink", "粉色"),
        (.brown, "Brown", "棕色")
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Choose a Color")
                .font(.headline)
                .foregroundColor(.primary)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 10) {
                ForEach(colors, id: \.name) { colorInfo in
                    ColorButtonView(
                        color: colorInfo.color,
                        name: colorInfo.name,
                        chineseName: colorInfo.chineseName,
                        isSelected: selectedColor == colorInfo.color,
                        onTap: {
                            onColorSelected(colorInfo.color)
                        }
                    )
                }
            }
        }
    }
}

/// Color button view
/// 
/// This view displays individual color options with
/// Chinese names for learning.
struct ColorButtonView: View {
    /// The color to display
    let color: Color
    /// The English name
    let name: String
    /// The Chinese name
    let chineseName: String
    /// Whether this color is selected
    let isSelected: Bool
    /// Action when color is tapped
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 5) {
                Circle()
                    .fill(color)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Circle()
                            .stroke(isSelected ? Color.black : Color.clear, lineWidth: 3)
                    )
                
                Text(chineseName)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

/// Dinosaur part selector
/// 
/// This view allows children to select which part of the dinosaur
/// they want to color while learning body part vocabulary.
struct DinosaurPartSelector: View {
    /// Binding to current part
    @Binding var currentPart: DinosaurPart
    /// Action when part is selected
    let onPartSelected: (DinosaurPart) -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Select Part")
                .font(.headline)
                .foregroundColor(.primary)
            
            HStack(spacing: 15) {
                ForEach(DinosaurPart.allCases, id: \.self) { part in
                    PartButtonView(
                        part: part,
                        isSelected: currentPart == part,
                        onTap: {
                            onPartSelected(part)
                        }
                    )
                }
            }
        }
    }
}

/// Part button view
/// 
/// This view displays individual dinosaur part options
/// with Chinese names for learning.
struct PartButtonView: View {
    /// The part to display
    let part: DinosaurPart
    /// Whether this part is selected
    let isSelected: Bool
    /// Action when part is tapped
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 5) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(isSelected ? Color.blue : Color.gray.opacity(0.3))
                    .frame(width: 60, height: 40)
                    .overlay(
                        Text(part.chineseName)
                            .font(.caption)
                            .foregroundColor(isSelected ? .white : .primary)
                    )
                
                Text(part.displayName)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

/// Coloring completion view
/// 
/// This view displays when the coloring activity is complete
/// with encouragement and celebration.
struct ColoringCompleteView: View {
    /// Action to continue
    let onContinue: () -> Void
    
    /// Character manager for character display
    @StateObject private var characterManager = CharacterManager.shared
    
    var body: some View {
        VStack(spacing: 30) {
            // Celebration
            VStack(spacing: 15) {
                Text("🎨 Beautiful!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("Your dinosaur looks amazing!")
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
            
            // Character encouragement
            if let character = characterManager.activeCharacter {
                VStack(spacing: 10) {
                    Text("Great coloring, Silas!")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                }
            }
            
            // Continue button
            Button(action: onContinue) {
                HStack {
                    Image(systemName: "arrow.right.circle.fill")
                    Text("Continue")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(25)
            }
        }
    }
}

/// Puzzle activity view (placeholder for future implementation)
/// 
/// This view will provide puzzle activities for learning
/// Chinese vocabulary and concepts.
struct PuzzleActivityView: View {
    /// Action to go back
    let onBack: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Button(action: onBack) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.primary)
                }
                
                Spacer()
                
                Text("Puzzle Activity")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            // Placeholder content
            VStack(spacing: 30) {
                Image(systemName: "puzzlepiece.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                Text("Puzzle Coming Soon!")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Text("Fun puzzle activities are being developed to help you learn Chinese!")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }
}

/// Story activity view (placeholder for future implementation)
/// 
/// This view will provide interactive stories for learning
/// Chinese vocabulary and cultural concepts.
struct StoryActivityView: View {
    /// Action to go back
    let onBack: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Button(action: onBack) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.primary)
                }
                
                Spacer()
                
                Text("Story Activity")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            // Placeholder content
            VStack(spacing: 30) {
                Image(systemName: "book.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.purple)
                
                Text("Stories Coming Soon!")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Text("Interactive stories are being developed to help you learn Chinese!")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }
}

/// Preview provider for ActivityView
struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
