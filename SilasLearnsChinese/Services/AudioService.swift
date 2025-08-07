import Foundation
import AVFoundation
import Combine

/// Manages audio playback for pronunciation and background music
/// 
/// This service handles all audio functionality including pronunciation
/// of Chinese words, background music, and sound effects.
class AudioService: ObservableObject {
    /// Shared instance for singleton access
    static let shared = AudioService()
    
    /// Audio player for pronunciation
    private var pronunciationPlayer: AVAudioPlayer?
    
    /// Audio player for background music
    private var backgroundMusicPlayer: AVAudioPlayer?
    
    /// Audio player for sound effects
    private var soundEffectPlayer: AVAudioPlayer?
    
    /// Current audio session configuration
    private var audioSession: AVAudioSession?
    
    /// Whether audio is currently playing
    @Published var isPlaying: Bool = false
    
    /// Current volume level (0.0 to 1.0)
    @Published var volume: Float = 0.8
    
    /// Whether background music is enabled
    @Published var backgroundMusicEnabled: Bool = true
    
    /// Whether pronunciation audio is enabled
    @Published var pronunciationEnabled: Bool = true
    
    /// Delegate for audio player completion callbacks
    private var audioDelegate: AudioPlayerDelegate?
    
    /// Private initializer for singleton pattern
    private init() {
        setupAudioSession()
    }
    
    /// Sets up the audio session for the app
    /// 
    /// This method configures the audio session to work properly
    /// with the app's audio requirements.
    func setupAudioSession() -> Void {
        do {
            audioSession = AVAudioSession.sharedInstance()
            try audioSession?.setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try audioSession?.setActive(true)
        } catch {
            print("Failed to setup audio session: \(error)")
        }
    }
    
    /// Prepares the audio session for playback
    /// 
    /// This method ensures the audio session is properly configured
    /// before playing any audio content.
    func prepareAudioSession() -> Void {
        do {
            try audioSession?.setActive(true)
        } catch {
            print("Failed to activate audio session: \(error)")
        }
    }
    
    /// Plays pronunciation for a vocabulary word
    /// 
    /// - Parameters:
    ///   - word: The vocabulary word to pronounce
    ///   - completion: Optional completion handler called when playback finishes
    func playPronunciation(for word: VocabularyWord, completion: (() -> Void)? = nil) -> Void {
        guard pronunciationEnabled else {
            completion?()
            return
        }
        
        // Create audio file URL
        guard let audioURL = Bundle.main.url(forResource: word.audioFileName, withExtension: "mp3") else {
            print("Audio file not found for word: \(word.chinese)")
            completion?()
            return
        }
        
        do {
            pronunciationPlayer = try AVAudioPlayer(contentsOf: audioURL)
            audioDelegate = AudioPlayerDelegate(completion: completion)
            pronunciationPlayer?.delegate = audioDelegate
            pronunciationPlayer?.volume = volume
            pronunciationPlayer?.play()
            isPlaying = true
        } catch {
            print("Failed to play pronunciation: \(error)")
            completion?()
        }
    }
    
    /// Plays background music
    /// 
    /// - Parameters:
    ///   - musicName: The name of the background music file
    ///   - loop: Whether the music should loop continuously
    func playBackgroundMusic(_ musicName: String, loop: Bool = true) -> Void {
        guard backgroundMusicEnabled else { return }
        
        // Create audio file URL
        guard let audioURL = Bundle.main.url(forResource: musicName, withExtension: "mp3") else {
            print("Background music file not found: \(musicName)")
            return
        }
        
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: audioURL)
            backgroundMusicPlayer?.numberOfLoops = loop ? -1 : 0 // -1 for infinite loop
            backgroundMusicPlayer?.volume = volume * 0.5 // Lower volume for background music
            backgroundMusicPlayer?.play()
        } catch {
            print("Failed to play background music: \(error)")
        }
    }
    
    /// Stops background music
    func stopBackgroundMusic() -> Void {
        backgroundMusicPlayer?.stop()
    }
    
    /// Plays a sound effect
    /// 
    /// - Parameters:
    ///   - effectName: The name of the sound effect file
    ///   - completion: Optional completion handler called when playback finishes
    func playSoundEffect(_ effectName: String, completion: (() -> Void)? = nil) -> Void {
        // Create audio file URL
        guard let audioURL = Bundle.main.url(forResource: effectName, withExtension: "mp3") else {
            print("Sound effect file not found: \(effectName)")
            completion?()
            return
        }
        
        do {
            soundEffectPlayer = try AVAudioPlayer(contentsOf: audioURL)
            soundEffectPlayer?.delegate = AudioPlayerDelegate(completion: completion)
            soundEffectPlayer?.volume = volume
            soundEffectPlayer?.play()
        } catch {
            print("Failed to play sound effect: \(error)")
            completion?()
        }
    }
    
    /// Stops all audio playback
    func stopAllAudio() -> Void {
        pronunciationPlayer?.stop()
        backgroundMusicPlayer?.stop()
        soundEffectPlayer?.stop()
        isPlaying = false
    }
    
    /// Sets the volume level for all audio players
    /// 
    /// - Parameter newVolume: The new volume level (0.0 to 1.0)
    func setVolume(_ newVolume: Float) -> Void {
        volume = max(0.0, min(1.0, newVolume))
        pronunciationPlayer?.volume = volume
        backgroundMusicPlayer?.volume = volume * 0.5
        soundEffectPlayer?.volume = volume
    }
    
    /// Plays a success sound effect
    func playSuccessSound() -> Void {
        playSoundEffect("success")
    }
    
    /// Plays an error sound effect
    func playErrorSound() -> Void {
        playSoundEffect("error")
    }
    
    /// Plays a click sound effect
    func playClickSound() -> Void {
        playSoundEffect("click")
    }
    
    /// Plays a celebration sound effect
    func playCelebrationSound() -> Void {
        playSoundEffect("celebration")
    }
    
    /// Toggles background music on/off
    func toggleBackgroundMusic() -> Void {
        backgroundMusicEnabled.toggle()
        if backgroundMusicEnabled {
            playBackgroundMusic("gentle_background")
        } else {
            stopBackgroundMusic()
        }
    }
    
    /// Toggles pronunciation audio on/off
    func togglePronunciation() -> Void {
        pronunciationEnabled.toggle()
    }
}

/// Delegate for AVAudioPlayer to handle completion callbacks
/// 
/// This class manages the completion handlers for audio playback
/// and ensures proper cleanup after audio finishes playing.
class AudioPlayerDelegate: NSObject, AVAudioPlayerDelegate {
    /// Completion handler to call when audio finishes
    private let completion: (() -> Void)?
    
    /// Initializes the delegate with a completion handler
    /// 
    /// - Parameter completion: The completion handler to call when audio finishes
    init(completion: (() -> Void)?) {
        self.completion = completion
        super.init()
    }
    
    /// Called when audio playback finishes
    /// 
    /// - Parameter player: The audio player that finished playing
    /// - Parameter successfully: Whether the playback finished successfully
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) -> Void {
        AudioService.shared.isPlaying = false
        completion?()
    }
    
    /// Called when audio playback encounters an error
    /// 
    /// - Parameter player: The audio player that encountered an error
    /// - Parameter error: The error that occurred
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) -> Void {
        print("Audio player decode error: \(error?.localizedDescription ?? "Unknown error")")
        AudioService.shared.isPlaying = false
        completion?()
    }
}

/// Audio file names for different types of content
/// 
/// This enum provides a centralized list of audio file names
/// used throughout the app for consistency and easy management.
enum AudioFiles {
    /// Background music files
    static let backgroundMusic = "gentle_background"
    static let celebrationMusic = "celebration_music"
    
    /// Sound effect files
    static let success = "success_sound"
    static let error = "error_sound"
    static let click = "click_sound"
    static let celebration = "celebration_sound"
    
    /// Character interaction sounds
    static let dinosaurGreeting = "dinosaur_greeting"
    static let pandaTeaching = "panda_teaching"
    static let birdChirp = "bird_chirp"
    static let rabbitHop = "rabbit_hop"
    static let fishSplash = "fish_splash"
}
