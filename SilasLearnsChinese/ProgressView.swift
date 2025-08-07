import SwiftUI

/// Progress view for tracking learning achievements
/// 
/// This view displays learning progress, achievements, and statistics
/// to help children and parents track learning development.
struct ProgressView: View {
    /// Progress manager for learning data
    @StateObject private var progressManager = ProgressManager.shared
    /// Character manager for character display
    @StateObject private var characterManager = CharacterManager.shared
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            VStack(spacing: 10) {
                Text("Your Progress")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("See how much you've learned!")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Progress overview
            VStack(spacing: 30) {
                // Stats cards
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                    StatCardView(
                        title: "Words Learned",
                        value: "\(progressManager.totalWordsLearned())",
                        icon: "book.fill",
                        color: .blue
                    )
                    
                    StatCardView(
                        title: "Sessions",
                        value: "\(progressManager.totalSessions())",
                        icon: "play.fill",
                        color: .green
                    )
                    
                    StatCardView(
                        title: "Average Score",
                        value: "\(Int(progressManager.averageScore()))%",
                        icon: "star.fill",
                        color: .orange
                    )
                    
                    StatCardView(
                        title: "Streak",
                        value: "\(progressManager.currentStreak) days",
                        icon: "flame.fill",
                        color: .red
                    )
                }
                
                // Character encouragement
                if let character = characterManager.activeCharacter {
                    VStack(spacing: 10) {
                        Text("Keep up the great work, Silas!")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(0.8))
                    )
                }
                
                // Coming soon message
                VStack(spacing: 15) {
                    Image(systemName: "chart.bar.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    
                    Text("Detailed Progress Coming Soon!")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text("More detailed progress tracking and achievements will be available in future updates!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .padding()
    }
}

/// Stat card view for displaying progress statistics
/// 
/// This view displays individual statistics with attractive
/// design and clear visual hierarchy.
struct StatCardView: View {
    /// Card title
    let title: String
    /// Card value
    let value: String
    /// Card icon
    let icon: String
    /// Card color
    let color: Color
    
    var body: some View {
        VStack(spacing: 15) {
            // Icon
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
            }
            
            // Value
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            // Title
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.8))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
}

/// Preview provider for ProgressView
struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
