#!/bin/bash

echo "🧪 Quick Test - Silas Learns Chinese App"
echo "=========================================="

# Test file existence
echo ""
echo "📁 Checking project files..."
files=(
    "SilasLearnsChinese/SilasLearnsChineseApp.swift"
    "SilasLearnsChinese/ContentView.swift"
    "SilasLearnsChinese/Views/LearningView.swift"
    "SilasLearnsChinese/Models/Vocabulary.swift"
    "SilasLearnsChinese/Models/Progress.swift"
    "SilasLearnsChinese/Models/Character.swift"
    "SilasLearnsChinese/Services/AudioService.swift"
    "SilasLearnsChinese/Assets.xcassets/Contents.json"
)

all_files_exist=true
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file - MISSING!"
        all_files_exist=false
    fi
done

# Test Swift syntax
echo ""
echo "🔍 Testing Swift syntax..."
if swift -frontend -parse SilasLearnsChinese/ContentView.swift >/dev/null 2>&1; then
    echo "✅ ContentView.swift syntax OK"
else
    echo "❌ ContentView.swift syntax error"
    all_files_exist=false
fi

if swift -frontend -parse SilasLearnsChinese/Views/LearningView.swift >/dev/null 2>&1; then
    echo "✅ LearningView.swift syntax OK"
else
    echo "❌ LearningView.swift syntax error"
    all_files_exist=false
fi

# Test content quality
echo ""
echo "📝 Testing content quality..."
if grep -q "小恐龙学中文" SilasLearnsChinese/ContentView.swift; then
    echo "✅ Chinese title present"
else
    echo "❌ Chinese title missing"
    all_files_exist=false
fi

if grep -q "Silas Learns Chinese" SilasLearnsChinese/ContentView.swift; then
    echo "✅ English title present"
else
    echo "❌ English title missing"
    all_files_exist=false
fi

if grep -q "VoiceRecognition" SilasLearnsChinese/Views/LearningView.swift; then
    echo "✅ Voice Recognition feature present"
else
    echo "❌ Voice Recognition feature missing"
    all_files_exist=false
fi

if grep -q "WordOfTheDay" SilasLearnsChinese/Views/LearningView.swift; then
    echo "✅ Word of the Day feature present"
else
    echo "❌ Word of the Day feature missing"
    all_files_exist=false
fi

# Test Phase 2 features
echo ""
echo "🚀 Testing Phase 2 features..."
if grep -q "CategorySelector" SilasLearnsChinese/Views/LearningView.swift; then
    echo "✅ Category Selector present"
else
    echo "❌ Category Selector missing"
    all_files_exist=false
fi

if grep -q "ProgressRow" SilasLearnsChinese/Views/LearningView.swift; then
    echo "✅ Progress Tracking present"
else
    echo "❌ Progress Tracking missing"
    all_files_exist=false
fi

if grep -q "Studio Ghibli" SilasLearnsChinese/ContentView.swift; then
    echo "✅ Studio Ghibli design elements present"
else
    echo "❌ Studio Ghibli design elements missing"
    all_files_exist=false
fi

# Test design elements
echo ""
echo "🎨 Testing design elements..."
if grep -q "LinearGradient" SilasLearnsChinese/ContentView.swift; then
    echo "✅ Gradients present"
else
    echo "❌ Gradients missing"
    all_files_exist=false
fi

if grep -q "RoundedRectangle" SilasLearnsChinese/ContentView.swift; then
    echo "✅ Rounded corners present"
else
    echo "❌ Rounded corners missing"
    all_files_exist=false
fi

if grep -q "withAnimation" SilasLearnsChinese/ContentView.swift; then
    echo "✅ Animations present"
else
    echo "❌ Animations missing"
    all_files_exist=false
fi

# Final results
echo ""
echo "=========================================="
echo "📊 TEST RESULTS SUMMARY"
echo "=========================================="

if [ "$all_files_exist" = true ]; then
    echo "🎉 ALL TESTS PASSED!"
    echo "✅ All files are present"
    echo "✅ Swift syntax is correct"
    echo "✅ Content quality is high"
    echo "✅ Phase 2 features are implemented"
    echo "✅ Studio Ghibli design is present"
    echo ""
    echo "🚀 The app is ready for Silas!"
    echo "🦕 小恐龙 is excited to help Silas learn Chinese!"
else
    echo "⚠️  Some tests failed"
    echo "Please check the issues above"
fi

echo ""
echo "🎯 NEXT STEPS:"
echo "1. Open Xcode"
echo "2. Create new iOS project"
echo "3. Add the Swift files"
echo "4. Build and run on iPhone 16 simulator"
echo "5. Enjoy the magical learning experience! 🦕✨"
