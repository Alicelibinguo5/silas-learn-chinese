#!/bin/bash

# Build script for Silas Learns Chinese iOS App
# This script helps build and test the app

set -e

echo "🦕 Building Silas Learns Chinese iOS App..."
echo "=========================================="

# Check if Xcode is installed
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Error: Xcode is not installed or not in PATH"
    echo "Please install Xcode from the App Store"
    exit 1
fi

# Check if we're in the right directory
if [ ! -f "SilasLearnsChinese.xcodeproj/project.pbxproj" ]; then
    echo "❌ Error: Not in the correct directory"
    echo "Please run this script from the project root"
    exit 1
fi

# Clean previous builds
echo "🧹 Cleaning previous builds..."
xcodebuild clean -project SilasLearnsChinese.xcodeproj -scheme SilasLearnsChinese

# Build the project
echo "🔨 Building project..."
xcodebuild build -project SilasLearnsChinese.xcodeproj -scheme SilasLearnsChinese -destination 'platform=iOS Simulator,name=iPhone 14'

# Run tests
echo "🧪 Running tests..."
xcodebuild test -project SilasLearnsChinese.xcodeproj -scheme SilasLearnsChinese -destination 'platform=iOS Simulator,name=iPhone 14'

echo "✅ Build completed successfully!"
echo ""
echo "🎉 Silas Learns Chinese is ready!"
echo ""
echo "To run the app in Xcode:"
echo "1. Open SilasLearnsChinese.xcodeproj in Xcode"
echo "2. Select a simulator (iPhone 14 recommended)"
echo "3. Press Cmd+R to build and run"
echo ""
echo "Features implemented in MVP:"
echo "✅ 31 basic Chinese vocabulary words"
echo "✅ 3 interactive learning activities"
echo "✅ Simple progress tracking"
echo "✅ Character system with 小恐龙"
echo "✅ Studio Ghibli-inspired design"
echo "✅ Audio service for pronunciation"
echo "✅ Coloring activity with dinosaurs"
echo "✅ Comprehensive test suite"
echo ""
echo "Next steps for Phase 2:"
echo "📝 Add more vocabulary words (200 total)"
echo "🎤 Implement voice recognition"
echo "📊 Enhanced progress analytics"
echo "🎨 Add actual character artwork"
echo "🔊 Add pronunciation audio files"
