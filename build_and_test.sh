#!/bin/bash

echo "🚀 Building Silas Learns Chinese App..."
echo "========================================"

# Check if Xcode project exists
if [ ! -d "SilasLearnsChinese.xcodeproj" ]; then
    echo "❌ Xcode project not found!"
    exit 1
fi

# Check if all required files exist
echo "📁 Checking project files..."
required_files=(
    "SilasLearnsChinese/SilasLearnsChineseApp.swift"
    "SilasLearnsChinese/ContentView.swift"
    "SilasLearnsChinese/Views/LearningView.swift"
    "SilasLearnsChinese/Models/Vocabulary.swift"
    "SilasLearnsChinese/Models/Progress.swift"
    "SilasLearnsChinese/Models/Character.swift"
    "SilasLearnsChinese/Services/AudioService.swift"
    "SilasLearnsChinese/Assets.xcassets/Contents.json"
    "SilasLearnsChinese/Info.plist"
)

all_files_exist=true
for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file - MISSING!"
        all_files_exist=false
    fi
done

if [ "$all_files_exist" = false ]; then
    echo "❌ Some required files are missing!"
    exit 1
fi

echo ""
echo "🔨 Building project..."

# Try to build the project
if xcodebuild -project SilasLearnsChinese.xcodeproj -scheme SilasLearnsChinese -destination 'platform=iOS Simulator,name=iPhone 16' build; then
    echo ""
    echo "🎉 BUILD SUCCESSFUL!"
    echo "✅ All files are present"
    echo "✅ Project builds without errors"
    echo "✅ Ready to run in Xcode"
    echo ""
    echo "🚀 NEXT STEPS:"
    echo "1. Open SilasLearnsChinese.xcodeproj in Xcode"
    echo "2. Select iPhone 16 simulator"
    echo "3. Press Cmd+R to build and run"
    echo "4. Enjoy the magical learning experience! 🦕✨"
else
    echo ""
    echo "❌ BUILD FAILED!"
    echo "Please check the error messages above."
    exit 1
fi
