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
    
    var rectangles: [PathTrainingViewGridCellView] = []
    var enterPointArrows: [UIImageView] = []
    var selectedRectangleIndex: Int? = nil
    
    @Published var isTraining: Bool = false
    var currentStartPoint: String = ""
    var currentEndPoint: String = ""
    
    init() {
        super.init(frame: .zero)
        
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        tapGesture.numberOfTapsRequired = 2 // Detect double tap
        self.addGestureRecognizer(tapGesture)
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
            self.rectangles.forEach {
                $0.isUserInteractionEnabled = false
                self.addSubview($0)
                
                if ($0.name.contains("入口")) {
                    // 在左邊
                    if ($0.frame.minX < self.frame.width * 0.2) {
                        AVSpeechSynthesizerService.shared.continuouslySpeak(content: "\($0.name)在左邊")
                    }
                    else if ($0.frame.minX > self.frame.width * 0.8) { // 在右邊
                        AVSpeechSynthesizerService.shared.continuouslySpeak(content: "\($0.name)在右邊")
                        
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
            AVSpeechSynthesizerService.shared.speakNextUtterance()
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        if (!self.isTraining) {
            return
        }
        
        let location = touch.location(in: self)
        selectedRectangleIndex = rectangles.firstIndex { $0.frame.contains(location) }
        if let index = selectedRectangleIndex {
            
            let view = self.rectangles[index]
            if( view.name == self.currentStartPoint) {
                AudioPlayerService.shared.playSound(name: SoundEffectConstant.start)

                if let bgColor = view.backgroundColor {
                    UIView.animate(withDuration: 0.2, animations: {
                        view.backgroundColor = bgColor.withAlphaComponent(0.6)
                    }) { _ in
                        // 恢復原來的背景色
                        UIView.animate(withDuration: 0.2) {
                            view.backgroundColor = bgColor
                        }
                    }
                }
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        print("touchesMoved, touches=\(touches)")
        
        guard let touch = touches.first, let index = selectedRectangleIndex else {
            return
        }
        
        //        let location = touch.location(in: self)
        //        let prevLocation = touch.previousLocation(in: self)
        
        //        rectangles[index].frame.origin = CGPoint(x: location.x - rectangles[index].frame.width / 2, y: location.y - rectangles[index].frame.height / 2)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedRectangleIndex = nil
    }
    
    func startTraining(start: String, end: String) {
        AVSpeechSynthesizerService.shared.continuouslySpeak(content: "訓練開始")

        self.isTraining = true
        self.currentStartPoint = start
        self.currentEndPoint = end
        let direction = self.getDirection(name: end)
        AVSpeechSynthesizerService.shared.continuouslySpeak(content: "\(end)在\(direction)方向")
    }
    
    func stopTraining() {
        self.isTraining = false
        AudioPlayerService.shared.playSound(name: SoundEffectConstant.end)
    }
    
    func getDirection(name: String) -> String {
        guard let rectangle = self.rectangles.first(where: { $0.name == name })
        else { return "" }
        
        let point = CGPoint(x: rectangle.frame.midX, y: rectangle.frame.minY)
        //        let convertedPoint = rectangle.convert(point, to: self)
        
        // Calculate the angle between the converted point and the center of the view
        let angle = atan2(point.y - self.center.y, point.x - self.center.x)
        
        // Convert the angle to degrees
        let degrees = angle * (180.0 / .pi)
        print("point = \(point), angle=\(angle), degrees=\(degrees)")
        //        print("point = \(point), convertedPoint=\(convertedPoint), angle=\(angle), degrees=\(degrees)")
        
        // Determine the direction based on the angle
        return degrees.clockDirection()
    }
}
