import SwiftUI

/// 🌟 Magical Studio Ghibli App Icon Component
/// Inspired by Totoro and Spirited Away for the Chinese learning app
struct MagicalAppIcon: View {
    @State private var isAnimating = false
    @State private var sparkleOpacity = 0.3
    
    var body: some View {
        ZStack {
            // Simple clean gradient background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.39, green: 0.71, blue: 0.47),  // Soft forest green
                    Color(red: 0.55, green: 0.78, blue: 0.94)   // Soft sky blue
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            
            // Simple floating sparkles
            ForEach(0..<4, id: \.self) { index in
                MagicalSparkle()
                    .offset(
                        x: CGFloat.random(in: -40...40),
                        y: CGFloat.random(in: -40...40)
                    )
                    .opacity(sparkleOpacity)
                    .animation(
                        .easeInOut(duration: 2.0)
                        .repeatForever(autoreverses: true)
                        .delay(Double(index) * 0.5),
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
            
            // Simple Chinese character (中)
            Text("中")
                .font(.system(size: 36, weight: .bold, design: .default))
                .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.0))  // Simple gold
                .shadow(color: .black, radius: 2, x: 1, y: 1)  // Simple shadow
                .offset(x: 25, y: 0)
            
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

/// Enhanced Totoro-inspired character for the app icon
struct TotoroCharacter: View {
    @State private var eyeBlink = false
    
    var body: some View {
        ZStack {
            // Body shadow for depth
            Ellipse()
                .fill(Color(red: 0.27, green: 0.35, blue: 0.45))
                .frame(width: 52, height: 67)
                .offset(x: 2, y: 7)
            
            // Main body (enhanced)
            Ellipse()
                .fill(Color(red: 0.37, green: 0.45, blue: 0.55))
                .frame(width: 50, height: 65)
            
            // Belly with pattern
            Ellipse()
                .fill(Color(red: 0.86, green: 0.92, blue: 0.96))
                .frame(width: 35, height: 45)
                .offset(y: 8)
            
            // Belly chevron patterns (like real Totoro)
            VStack(spacing: 4) {
                Ellipse()
                    .fill(Color(red: 0.78, green: 0.84, blue: 0.88))
                    .frame(width: 28, height: 4)
                Ellipse()
                    .fill(Color(red: 0.78, green: 0.84, blue: 0.88))
                    .frame(width: 24, height: 4)
                Ellipse()
                    .fill(Color(red: 0.78, green: 0.84, blue: 0.88))
                    .frame(width: 20, height: 4)
            }
            .offset(y: 12)
            
            // Enhanced ears with inner ears
            HStack(spacing: 30) {
                ZStack {
                    Ellipse()
                        .fill(Color(red: 0.29, green: 0.37, blue: 0.47))
                        .frame(width: 16, height: 22)
                        .rotationEffect(.degrees(-15))
                    Ellipse()
                        .fill(Color(red: 0.47, green: 0.55, blue: 0.65))
                        .frame(width: 10, height: 14)
                        .rotationEffect(.degrees(-15))
                }
                
                ZStack {
                    Ellipse()
                        .fill(Color(red: 0.29, green: 0.37, blue: 0.47))
                        .frame(width: 16, height: 22)
                        .rotationEffect(.degrees(15))
                    Ellipse()
                        .fill(Color(red: 0.47, green: 0.55, blue: 0.65))
                        .frame(width: 10, height: 14)
                        .rotationEffect(.degrees(15))
                }
            }
            .offset(y: -28)
            
            // Enhanced eyes with highlights
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.black)
                        .frame(width: eyeBlink ? 8 : 8, height: eyeBlink ? 2 : 8)
                    if !eyeBlink {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 3, height: 3)
                            .offset(x: -1, y: -1)
                    }
                }
                
                ZStack {
                    Circle()
                        .fill(Color.black)
                        .frame(width: eyeBlink ? 8 : 8, height: eyeBlink ? 2 : 8)
                    if !eyeBlink {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 3, height: 3)
                            .offset(x: -1, y: -1)
                    }
                }
            }
            .offset(y: -8)
            .onAppear {
                withAnimation(.easeInOut(duration: 3.0).repeatForever()) {
                    eyeBlink.toggle()
                }
            }
            
            // Enhanced nose
            Ellipse()
                .fill(Color(red: 0.24, green: 0.24, blue: 0.24))
                .frame(width: 5, height: 4)
                .offset(y: 2)
            
            // Whiskers
            Group {
                // Left whiskers
                Rectangle()
                    .fill(Color(red: 0.31, green: 0.31, blue: 0.31))
                    .frame(width: 12, height: 1)
                    .offset(x: -18, y: 0)
                Rectangle()
                    .fill(Color(red: 0.31, green: 0.31, blue: 0.31))
                    .frame(width: 12, height: 1)
                    .offset(x: -18, y: 3)
                
                // Right whiskers
                Rectangle()
                    .fill(Color(red: 0.31, green: 0.31, blue: 0.31))
                    .frame(width: 12, height: 1)
                    .offset(x: 18, y: 0)
                Rectangle()
                    .fill(Color(red: 0.31, green: 0.31, blue: 0.31))
                    .frame(width: 12, height: 1)
                    .offset(x: 18, y: 3)
            }
        }
        .offset(x: -18, y: 5)
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
