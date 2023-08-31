//
//  AVSpeechSynthesizerService.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/30.
//

import Foundation
import AVFoundation

class AVSpeechSynthesizerService: NSObject {
    static let shared = AVSpeechSynthesizerService()
    let synthesizer = AVSpeechSynthesizer()
    
    var utterancesInQueues: [AVSpeechUtterance] = []
    
    override init() {
        super.init()
        
        self.synthesizer.delegate = self
    }
    
    func speak(content: String) {
        if (self.utterancesInQueues.count > 0) {
            print("執行佇列中")
            return
        }
        
        if self.synthesizer.isSpeaking {
            self.synthesizer.stopSpeaking(at: .immediate)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let utterance = AVSpeechUtterance(string: content)
                utterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
                self.synthesizer.speak(utterance)
            }
        } else {
            let utterance = AVSpeechUtterance(string: content)
            utterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
            self.synthesizer.speak(utterance)
        }
        
        print("Is speaking: \(self.synthesizer.isSpeaking)")
        print("content: \(content)")
    }
    
    func continuouslySpeak(content: String) {
        let utterance = AVSpeechUtterance(string: content)
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        
        self.utterancesInQueues.append(utterance)
    }
    
    func speakNextUtterance() {
        if let nextUtterance = self.utterancesInQueues.first ,
           !self.synthesizer.isSpeaking {
            self.synthesizer.delegate = self
            self.synthesizer.speak(nextUtterance)
            print(nextUtterance.speechString)
        }
    }
}

extension AVSpeechSynthesizerService: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        // Remove the finished utterance from the array
        if let index = self.utterancesInQueues.firstIndex(of: utterance) {
            self.utterancesInQueues.remove(at: index)
        }
        
        // Speak the next utterance
        speakNextUtterance()
    }
}
