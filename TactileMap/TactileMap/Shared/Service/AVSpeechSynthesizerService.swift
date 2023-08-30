//
//  AVSpeechSynthesizerService.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/30.
//

import Foundation
import AVFoundation

class AVSpeechSynthesizerService {
    static let shared = AVSpeechSynthesizerService()
    static let synthesizer = AVSpeechSynthesizer()
    
    func speak(content: String) {
        if AVSpeechSynthesizerService.synthesizer.isSpeaking {
            AVSpeechSynthesizerService.synthesizer.stopSpeaking(at: .immediate)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let utterance = AVSpeechUtterance(string: content)
                utterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
                AVSpeechSynthesizerService.synthesizer.speak(utterance)
            }
        } else {
            let utterance = AVSpeechUtterance(string: content)
            utterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
            AVSpeechSynthesizerService.synthesizer.speak(utterance)
        }
        
        print("Is speaking: \(AVSpeechSynthesizerService.synthesizer.isSpeaking)")
    }
}
