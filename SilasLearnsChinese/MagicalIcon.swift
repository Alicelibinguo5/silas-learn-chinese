import SwiftUI

/// 🌟 Magical Studio Ghibli App Icon Component
/// Inspired by Totoro and Spirited Away for the Chinese learning app
struct MagicalAppIcon: View {
    @State private var isAnimating = false
    @State private var sparkleOpacity = 0.3
    
    var body: some View {
        ZStack {
            // Magical gradient background inspired by Spirited Away
            RadialGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.4, green: 0.8, blue: 0.6),  // Magical green
                    Color(red: 0.2, green: 0.6, blue: 0.8),  // Spirit blue
                    Color(red: 0.1, green: 0.4, blue: 0.7)   // Deep mystical blue
                ]),
                center: .center,
                startRadius: 20,
                endRadius: 150
            )
            
            // Floating magical elements
            ForEach(0..<8, id: \.self) { index in
                MagicalSparkle()
                    .offset(
                        x: CGFloat.random(in: -60...60),
                        y: CGFloat.random(in: -60...60)
                    )
                    .opacity(sparkleOpacity)
                    .animation(
                        .easeInOut(duration: 2.0)
                        .repeatForever(autoreverses: true)
                        .delay(Double(index) * 0.3),
                        value: sparkleOpacity
                    )
            }
            
            // Totoro-inspired character silhouette
            TotoroCharacter()
                .scaleEffect(isAnimating ? 1.05 : 1.0)
                .animation(
                    .easeInOut(duration: 3.0).repeatForever(autoreverses: true),
                    value: isAnimating
                )
            
            // Chinese character (中) with magical glow
            VStack {
                Text("中")
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .shadow(color: .yellow, radius: 8, x: 0, y: 0)
                    .shadow(color: .orange, radius: 4, x: 0, y: 0)
                
                Text("学")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.white)
                    .opacity(0.9)
            }
            .offset(x: 25, y: -10)
            
            // Magical border with Spirited Away-inspired elements
            RoundedRectangle(cornerRadius: 25)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            .white.opacity(0.6),
                            .yellow.opacity(0.4),
                            .white.opacity(0.6)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 3
                )
                .opacity(isAnimating ? 0.8 : 0.5)
        }
        .frame(width: 120, height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .onAppear {
            isAnimating = true
            sparkleOpacity = 0.8
        }
    }
}

/// Totoro-inspired character for the app icon
struct TotoroCharacter: View {
    var body: some View {
        ZStack {
            // Main body
            Ellipse()
                .fill(Color(red: 0.5, green: 0.5, blue: 0.6))
                .frame(width: 50, height: 65)
            
            // Belly
            Ellipse()
                .fill(Color(red: 0.8, green: 0.85, blue: 0.9))
                .frame(width: 35, height: 45)
                .offset(y: 8)
            
            // Ears
            HStack(spacing: 30) {
                Ellipse()
                    .fill(Color(red: 0.4, green: 0.4, blue: 0.5))
                    .frame(width: 15, height: 20)
                    .rotationEffect(.degrees(-15))
                
                Ellipse()
                    .fill(Color(red: 0.4, green: 0.4, blue: 0.5))
                    .frame(width: 15, height: 20)
                    .rotationEffect(.degrees(15))
            }
            .offset(y: -25)
            
            // Eyes
            HStack(spacing: 12) {
                Circle()
                    .fill(Color.black)
                    .frame(width: 6, height: 6)
                
                Circle()
                    .fill(Color.black)
                    .frame(width: 6, height: 6)
            }
            .offset(y: -8)
            
            // Nose
            Ellipse()
                .fill(Color.black)
                .frame(width: 4, height: 3)
                .offset(y: 2)
        }
        .offset(x: -20, y: 5)
    }
}

/// Magical sparkle effects inspired by Spirited Away
struct MagicalSparkle: View {
    @State private var rotation = 0.0
    
    var body: some View {
        ZStack {
            // Main sparkle
            Image(systemName: "sparkles")
                .font(.system(size: CGFloat.random(in: 8...16)))
                .foregroundColor(.white)
                .opacity(0.8)
            
            // Rotating glow
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            .yellow.opacity(0.6),
                            .clear
                        ]),
                        center: .center,
                        startRadius: 1,
                        endRadius: 8
                    )
                )
                .frame(width: 16, height: 16)
                .rotationEffect(.degrees(rotation))
        }
        .onAppear {
            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}

/// Large preview for App Store and testing
struct LargeMagicalIcon: View {
    var body: some View {
        MagicalAppIcon()
            .scaleEffect(8.5) // Scale up to 1024x1024 equivalent
            .frame(width: 1024, height: 1024)
            .background(Color.black)
    }
}

/// Preview for different icon sizes
struct IconPreview: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("🦕 Silas Learns Chinese")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Magical Studio Ghibli App Icons")
                .font(.title2)
                .foregroundColor(.secondary)
            
            HStack(spacing: 15) {
                VStack {
                    MagicalAppIcon()
                        .scaleEffect(0.5)
                        .frame(width: 60, height: 60)
                    Text("Small")
                        .font(.caption)
                }
                
                VStack {
                    MagicalAppIcon()
                        .frame(width: 120, height: 120)
                    Text("Medium")
                        .font(.caption)
                }
                
                VStack {
                    MagicalAppIcon()
                        .scaleEffect(1.5)
                        .frame(width: 180, height: 180)
                    Text("Large")
                        .font(.caption)
                }
            }
            
            Text("✨ Features:")
                .font(.headline)
                .padding(.top)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("🌟 Totoro-inspired character")
                Text("🎨 Spirited Away magical gradients")
                Text("🇨🇳 Chinese characters (中学)")
                Text("✨ Animated sparkles and glows")
                Text("🌲 Forest mystical atmosphere")
                Text("📱 Perfect for iPhone 16 Plus")
            }
            .font(.body)
            .foregroundColor(.secondary)
        }
        .padding()
    }
}

#Preview("App Icon") {
    MagicalAppIcon()
        .padding()
        .background(Color.gray.opacity(0.2))
}

#Preview("Icon Sizes") {
    IconPreview()
}

#Preview("Large Icon") {
    LargeMagicalIcon()
}
