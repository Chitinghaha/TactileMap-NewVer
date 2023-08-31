//
//  TouchMapView.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/30.
//

import Foundation
import UIKit

class PathTrainingView: UIView {
    
    var rectangles: [PathTrainingViewGridCellView] = []
    var enterPointArrows: [UIImageView] = []
    var selectedRectangleIndex: Int? = nil
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if (self.subviews.count == 0) {
            self.rectangles.forEach {
                self.addSubview($0)
                if ($0.name.contains("入口")) {
                    // 處理一開始入口事件：增加箭頭提示，且按到入口後需隱藏箭頭
                    print("入口：\($0.name), frame:\($0.frame), self.frame:\(self.frame)")
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
        let location = touch.location(in: self)
        selectedRectangleIndex = rectangles.firstIndex { $0.frame.contains(location) }
        if let index = selectedRectangleIndex {

        }
        else {
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
}
