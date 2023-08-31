//
//  AudioPlayerService.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/31.
//

import AVFoundation
import UIKit

class AudioPlayerService {
    
    static let shared = AudioPlayerService()
    
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category: \(error)")
        }
    }
    
    func playSound(name: String) {
        if let soundURL = Bundle.main.url(forResource: name, withExtension: "mp3") {
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                self.audioPlayer?.play()
            } catch {
                // 處理錯誤
                print("Error in AVAudioPlayer: \(error.localizedDescription)")
            }
        }
        else {
            print("Error: can not get \(name) file")
        }
        
    }
    
    
    func stopSound() {
        self.audioPlayer?.stop()
        print("Audio player stopped.")
    }
    
    
    func playLoopSound(name: String) {
        self.audioPlayer?.stop()
        
        if let soundURL = Bundle.main.url(forResource: name, withExtension: "mp3") {
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                self.audioPlayer?.numberOfLoops = -1  // Loop infinitely
                self.audioPlayer?.play()
                print("Audio file found. Playing the sound.")
            } catch {
                print("Error in AVAudioPlayer: \(error)")
            }
        }
        else {
            print("Error: can not get \(name) file")
        }
        
        
    }
}



