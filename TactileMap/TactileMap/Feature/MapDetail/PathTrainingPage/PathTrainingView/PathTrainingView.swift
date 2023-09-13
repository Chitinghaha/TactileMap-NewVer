//
//  TouchMapView.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/30.
//

import Foundation
import UIKit
import Combine

class PathTrainingView: UIView {
    
    private var cancellables = Set<AnyCancellable>()

    var gridViews: [PathTrainingViewGridCellView] = []
    //    var enterPointArrows: [UIImageView] = []
    var selectedViewIndex: Int? = nil
    
    @Published var isTraining: Bool = false
    var isPreparingTraing: Bool = false
    
    // 起點終點是否已確認
    @Published var didConfirmStartPoint: Bool = false
    @Published var didConfirmEndPoint: Bool = false

    var currentStartPoint: String = ""
    var currentEndPoint: String = ""
    
    init() {
        super.init(frame: .zero)
        
        self.isUserInteractionEnabled = true
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
//        tapGesture.numberOfTapsRequired = 2 // Detect double tap
//        self.addGestureRecognizer(tapGesture)
        
        self.setupBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if (self.isTraining) {
                self.stopTraining()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if (self.subviews.count == 0) {
            AVSpeechSynthesizerService.shared.continuouslySpeak(content: "進入路徑訓練模式")

            self.gridViews.forEach {
                $0.isUserInteractionEnabled = false
                self.addSubview($0)
//                $0.accessibilityValue = $0.name
//                $0.isAccessibilityElement = true

                if ($0.name.contains("入口")) {
                    // 在左邊
                    if ($0.frame.minX < self.frame.width * 0.2) {
                        AVSpeechSynthesizerService.shared.continuouslySpeak(content: "\($0.name)在左邊")
                    }
                    else if ($0.frame.minX > self.frame.width * 0.8) { // 在右邊
                        AVSpeechSynthesizerService.shared.continuouslySpeak(content: "\($0.name) 在右邊")
                        
                    }
                    else if ($0.frame.minY < self.frame.height * 0.2) { // 在上方
                        AVSpeechSynthesizerService.shared.continuouslySpeak(content: "\($0.name)在上方")
                    }
                    else if ($0.frame.minY > self.frame.height * 0.8) { // 在下方
                        AVSpeechSynthesizerService.shared.continuouslySpeak(content: "\($0.name)在下方")
                    }
                    //                else { //在中間的其他區域（？？
                    //                    AVSpeechSynthesizerService.shared.speak(content: "\($0.name)在中間區塊")
                    //                }
                }
            }
        }
        
        //        for (index, rectangle) in rectangles.enumerated() {
        //            context.setStrokeColor(rectangle.color.cgColor)
        //            context.setLineWidth(2.0)
        //            context.addRect(rectangle.frameRect)
        //            context.strokePath()
        //
        //            context.setFillColor(rectangle.color.cgColor)
        //            context.fill(rectangle.frameRect)
        //        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else {
//            return
//        }
//        if (!self.isPreparingTraing) {
//            return
//        }
//
//        let location = touch.location(in: self)
//
//        if let index = gridViews.lastIndex(where: { $0.frame.contains(location) }) {
//            AVSpeechSynthesizerService.shared.stop()
//            let view = self.gridViews[index]
////            if let bgColor = view.backgroundColor {
////                UIView.animate(withDuration: 0.2, animations: {
////                    view.backgroundColor = bgColor.withAlphaComponent(0.6)
////                }) { _ in
////                    // 恢復原來的背景色
////                    UIView.animate(withDuration: 0.2) {
////                        view.backgroundColor = bgColor
////                    }
////                }
////            }
//
//            if(view.name == self.currentStartPoint) {
//                AVSpeechSynthesizerService.shared.continuouslySpeak(content: "起點\(view.name)已確認")
//                self.didConfirmStartPoint = true
//            }
//            else if (view.name == self.currentEndPoint) {
//                AVSpeechSynthesizerService.shared.continuouslySpeak(content: "終點\(view.name)已確認")
//                self.didConfirmEndPoint = true
//            }
//            else {
//                AVSpeechSynthesizerService.shared.continuouslySpeak(content: "\(view.name)")
//            }
//
//        }
//
//    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, (self.isPreparingTraing || self.isTraining) else {
            return
        }
        print("touch = :\(touch)")
        let location = touch.location(in: self)
        let prevLocation = touch.previousLocation(in: self)
        let prevViewIndex = self.gridViews.lastIndex { $0.frame.contains(prevLocation) }
        self.selectedViewIndex = self.gridViews.lastIndex { $0.frame.contains(location) }
        
        if let index = self.selectedViewIndex,
           let prevViewIndex = prevViewIndex {
            
            let view = self.gridViews[index]
            let prevView = self.gridViews[prevViewIndex]
            if ((AudioPlayerService.shared.audioPlayer?.isPlaying ?? false
                || AVSpeechSynthesizerService.shared.synthesizer.isSpeaking)
                && view.name == prevView.name) {
                return
            }
            AudioPlayerService.shared.stopSound()
            AVSpeechSynthesizerService.shared.stop()

            if (self.isPreparingTraing) {
                if(view.name == self.currentStartPoint) {
                    AVSpeechSynthesizerService.shared.continuouslySpeak(content: "起點\(view.name)已確認")
                    self.didConfirmStartPoint = true
                }
                else if (view.name == self.currentEndPoint) {
                    AVSpeechSynthesizerService.shared.continuouslySpeak(content: "終點\(view.name)已確認")
                    self.didConfirmEndPoint = true
                }
                else {
                    AVSpeechSynthesizerService.shared.continuouslySpeak(content: "\(view.name)")
                }
            }
            else {
                if(view.name == self.currentStartPoint) {
                    AVSpeechSynthesizerService.shared.continuouslySpeak(content: "您已進入起點\(view.name)")
                }
                else if (view.name == self.currentEndPoint) {
                    AVSpeechSynthesizerService.shared.continuouslySpeak(content: "您已抵達終點\(view.name)")
                    AVSpeechSynthesizerService.shared.continuouslySpeak(content: "訓練結束")
                    self.stopTraining()
                }
                else if (view.name == "走道"){
                    AudioPlayerService.shared.playLoopSound(name: SoundEffectConstant.walking)
                }
                else {
                    AVSpeechSynthesizerService.shared.speak(content: "您已進入\(view.name)")
                }
            }
        }
        else if (self.selectedViewIndex != prevViewIndex){
            if (AVSpeechSynthesizerService.shared.synthesizer.isSpeaking) {
                return
            }
            AVSpeechSynthesizerService.shared.speak(content: "超出地圖邊界")
        }
        
        //        rectangles[index].frame.origin = CGPoint(x: location.x - rectangles[index].frame.width / 2, y: location.y - rectangles[index].frame.height / 2)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedViewIndex = nil
//        AudioPlayerService.shared.stopSound()
    }
    
    func prepairTraining(start: String, end: String) {
        if (start.count == 0 || end.count == 0) {
            AVSpeechSynthesizerService.shared.continuouslySpeak(content: "起點終點條件異常")
        }
        
        AVSpeechSynthesizerService.shared.stop()

        self.isPreparingTraing = true
        self.didConfirmStartPoint = false
        self.didConfirmEndPoint = false
        
        self.currentStartPoint = start
        var direction = self.getDirection(name: start)
        AVSpeechSynthesizerService.shared.continuouslySpeak(content: "起點\(start)位於畫面的\(direction)方向")
        
        self.currentEndPoint = end
        direction = self.getDirection(name: end)
        AVSpeechSynthesizerService.shared.continuouslySpeak(content: "終點\(end)位於畫面的\(direction)方向")
        AVSpeechSynthesizerService.shared.continuouslySpeak(content: "請點擊畫面確認起點終點位置")
    }
    
    func startTraining() {
        self.isPreparingTraing = false
        self.isTraining = true
        AudioPlayerService.shared.playSound(name: SoundEffectConstant.start)
        AVSpeechSynthesizerService.shared.continuouslySpeak(content: "訓練開始")
        
        let direction = self.getDirection(name: self.currentEndPoint, compareTo: self.currentStartPoint)
        AVSpeechSynthesizerService.shared.continuouslySpeak(content: "終點位於起點的\(direction)方向")

    }
    
    func stopTraining() {
        self.isTraining = false
        AudioPlayerService.shared.playSound(name: SoundEffectConstant.end)
    }
    
    func getDirection(name: String, compareTo specifiedTarget: String? = nil) -> String {
        guard let rectangle = self.gridViews.first(where: { $0.name == name })
        else { return "" }
        
        var targetPoint: CGPoint
        
        if let specifiedTarget = specifiedTarget,
           let specifiedPoint = self.gridViews.first(where: { $0.name == specifiedTarget })?.center {
            targetPoint = specifiedPoint
        }
        else {
            targetPoint = self.center
        }
        
        let point = rectangle.center
        
        // Calculate the angle between the converted point and the center of the view
        let angle = atan2(point.y - targetPoint.y, point.x - targetPoint.x)
        
        // Convert the angle to degrees
        let degrees = angle * (180.0 / .pi)
        
        // Determine the direction based on the angle
        return degrees.clockDirection()
    }
}

extension PathTrainingView {
    
    func setupBinding() {
        self.$didConfirmStartPoint.combineLatest(self.$didConfirmEndPoint)
            .sink { (didConfirmStartPoint, didConfirmEndPoint) in
                if (didConfirmStartPoint == true && didConfirmEndPoint == true) {
                    self.startTraining()
                }
            }
            .store(in: &cancellables)
    }
    
}
