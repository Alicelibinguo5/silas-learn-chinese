import SwiftUI

struct ContentView: View {
    @State private var isAnimating = false
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            // Magical Studio Ghibli background
            BackgroundView()
            
            // Main content
            VStack(spacing: 0) {
                // Header with floating elements
                HeaderView()
                
                // Tab navigation
                TabView(selection: $selectedTab) {
                    HomeView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                        .tag(0)
                    
                    LearningView()
                        .tabItem {
                            Image(systemName: "book.fill")
                            Text("Learn")
                        }
                        .tag(1)
                    
                    ActivitiesView()
                        .tabItem {
                            Image(systemName: "gamecontroller.fill")
                            Text("Play")
                        }
                        .tag(2)
                    
                                            LearningProgressView()
                        .tabItem {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                            Text("Progress")
                        }
                        .tag(3)
                }
                .accentColor(Color(red: 0.2, green: 0.6, blue: 0.4))
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}

// MARK: - Background View
struct BackgroundView: View {
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
                CloudView()
                    .offset(x: cloudOffset + CGFloat(index * 200), y: CGFloat(index * 50))
                    .opacity(0.6)
            }
            
            // Floating leaves
            ForEach(0..<5) { index in
                LeafView()
                    .offset(x: CGFloat(index * 80), y: CGFloat(index * 100))
                    .opacity(0.4)
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
                cloudOffset = -400
            }
        }
    }
}

// MARK: - Cloud View
struct CloudView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white.opacity(0.8))
                .frame(width: 60, height: 60)
            
            Circle()
                .fill(Color.white.opacity(0.6))
                .frame(width: 40, height: 40)
                .offset(x: 20, y: -10)
            
            Circle()
                .fill(Color.white.opacity(0.7))
                .frame(width: 50, height: 50)
                .offset(x: -15, y: 10)
        }
    }
}

// MARK: - Leaf View
struct LeafView: View {
    @State private var rotation: Double = 0
    
    var body: some View {
        Image(systemName: "leaf.fill")
            .font(.title2)
            .foregroundColor(Color(red: 0.4, green: 0.7, blue: 0.4))
            .rotationEffect(.degrees(rotation))
            .onAppear {
                withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
    }
}

// MARK: - Header View
struct HeaderView: View {
    @State private var isGlowing = false
    
    var body: some View {
        VStack(spacing: 15) {
            // App title with magical glow
            VStack(spacing: 8) {
                Text("小恐龙学中文")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
                    .shadow(color: Color(red: 0.2, green: 0.4, blue: 0.3).opacity(0.3), radius: isGlowing ? 8 : 4)
                
                Text("Silas Learns Chinese")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(Color(red: 0.3, green: 0.5, blue: 0.4))
            }
            .padding(.top, 20)
            
            // Welcome message with floating animation
            VStack(spacing: 8) {
                Text("Welcome back, Silas! 🦕")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
                
                Text("Ready for another magical learning adventure?")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(Color(red: 0.4, green: 0.6, blue: 0.5))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 10)
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                isGlowing = true
            }
        }
    }
}

// MARK: - Home View
struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Quick stats
                StatsView()
                
                // Today's learning
                TodayLearningView()
                
                // Quick actions
                QuickActionsView()
                
                // Recent progress
                RecentProgressView()
            }
            .padding()
        }
    }
}

// MARK: - Stats View
struct StatsView: View {
    var body: some View {
        HStack(spacing: 15) {
            StatCard(title: "Words Learned", value: "31", icon: "book.fill", color: .blue)
            StatCard(title: "Days Active", value: "7", icon: "calendar", color: .green)
            StatCard(title: "Perfect Scores", value: "12", icon: "star.fill", color: .orange)
        }
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
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            
            Text(title)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
    }
}

// MARK: - Today Learning View
struct TodayLearningView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Today's Learning")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
            
            VStack(spacing: 12) {
                LearningCard(
                    title: "Colors",
                    subtitle: "Learn 6 beautiful colors",
                    progress: 0.8,
                    icon: "paintpalette.fill",
                    color: .purple
                )
                
                LearningCard(
                    title: "Numbers",
                    subtitle: "Count from 1 to 10",
                    progress: 0.6,
                    icon: "number.circle.fill",
                    color: .orange
                )
                
                LearningCard(
                    title: "Animals",
                    subtitle: "Meet friendly animals",
                    progress: 0.4,
                    icon: "pawprint.fill",
                    color: .green
                )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 8)
        )
    }
}

struct LearningCard: View {
    let title: String
    let subtitle: String
    let progress: Double
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                
                // Progress bar
                ProgressView(value: progress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: color))
                    .scaleEffect(x: 1, y: 2, anchor: .center)
            }
            
            Spacer()
            
            Text("\(Int(progress * 100))%")
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(color)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.7))
        )
    }
}

// MARK: - Quick Actions View
struct QuickActionsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Quick Actions")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 15) {
                QuickActionCard(
                    title: "Tap & Learn",
                    icon: "hand.tap.fill",
                    color: .blue
                )
                
                QuickActionCard(
                    title: "Drag & Match",
                    icon: "arrow.up.and.down.and.arrow.left.and.right",
                    color: .green
                )
                
                QuickActionCard(
                    title: "Memory Game",
                    icon: "brain.head.profile",
                    color: .purple
                )
                
                QuickActionCard(
                    title: "Coloring",
                    icon: "paintbrush.fill",
                    color: .orange
                )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 8)
        )
    }
}

struct QuickActionCard: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
            
            Text(title)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.8))
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
    }
}

// MARK: - Recent Progress View
struct RecentProgressView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Recent Progress")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
            
            VStack(spacing: 10) {
                ProgressItem(title: "Learned 红色 (Red)", time: "2 hours ago", icon: "checkmark.circle.fill", color: .green)
                ProgressItem(title: "Completed Numbers Quiz", time: "Yesterday", icon: "star.fill", color: .orange)
                ProgressItem(title: "New Animal: 猫 (Cat)", time: "2 days ago", icon: "plus.circle.fill", color: .blue)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 8)
        )
    }
}

struct ProgressItem: View {
    let title: String
    let time: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.primary)
                
                Text(time)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.6))
        )
    }
}

// MARK: - Placeholder Views for Phase 2
struct ActivitiesView: View {
    var body: some View {
        VStack {
            Text("Activities & Games")
                .font(.largeTitle)
                .padding()
            
            Text("Phase 2: Advanced Interactive Activities")
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
