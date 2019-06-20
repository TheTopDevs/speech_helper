//
//  SpeechHelper.swift
//
//  Copyright © 2018. All rights reserved.
//

import Foundation
import AVFoundation

class SpeechHelper {
    
    private static let synthesizer = AVSpeechSynthesizer()
    
    static func play(text: String, language: String) {
        setAudioSession()
        handleSilentMode()
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.4
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        synthesizer.speak(utterance)
    }
    
    static func stop() {
        synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
    }
    
    private static func handleSilentMode() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        }
        catch let error as NSError {
            print("Error: Could not set audio category: \(error), \(error.userInfo)")
        }
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch let error as NSError {
            print("Error: Could not setActive to true: \(error), \(error.userInfo)")
        }
    }
    
    private static func setAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategorySoloAmbient)
            try audioSession.setMode(AVAudioSessionModeSpokenAudio)
            try audioSession.setActive(true)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
    }
}
