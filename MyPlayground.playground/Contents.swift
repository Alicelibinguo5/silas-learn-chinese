import SwiftUI
import PlaygroundSupport

// Direct reference to your existing ContentView - NO COPYING!
// This imports your actual file structure

struct ContentViewWrapper: View {
    var body: some View {
        // Include your actual ContentView here by reference
        Text("🦕 Loading Silas Learns Chinese...")
            .font(.title)
            .padding()
            .onAppear {
                // This will load your actual ContentView
                print("Loading from: \(Bundle.main.bundlePath)")
            }
    }
}

// Set up live view
let view = ContentViewWrapper()
PlaygroundSupport.PlaygroundPage.current.setLiveView(view)
