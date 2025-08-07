import SwiftUI

@main
struct SilasLearnsChineseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// Copy your full ContentView.swift content here
struct ContentView: View {
    @State private var isAnimating = false
    @State private var selectedTab = 0

    var body: some View {
        ZStack {
            // Magical Studio Ghibli background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.85, green: 0.92, blue: 0.88),
                    Color(red: 0.78, green: 0.88, blue: 0.82),
                    Color(red: 0.72, green: 0.85, blue: 0.78)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            Text("🦕 小恐龙学中文")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
