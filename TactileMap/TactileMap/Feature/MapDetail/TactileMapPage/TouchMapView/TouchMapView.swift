//
//  TouchMapView.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/30.
//

import Foundation
import UIKit

class TouchMapView: UIView {
    
    var rectangles: [TactileMapGridCellView] = []
    var selectedRectangleIndex: Int? = nil
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        self.rectangles.forEach {
            self.addSubview($0)
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
            AVSpeechSynthesizerService.shared.speak(content: rectangles[index].name)
        }
        else {
            AVSpeechSynthesizerService.shared.speak(content: "超出邊界")
        }
//        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesMoved, touches=\(touches)")

        guard let touch = touches.first, let index = selectedRectangleIndex else {
            return
        }

//        let location = touch.location(in: self)
//        let prevLocation = touch.previousLocation(in: self)
        
//        rectangles[index].frame.origin = CGPoint(x: location.x - rectangles[index].frame.width / 2, y: location.y - rectangles[index].frame.height / 2)
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedRectangleIndex = nil
        setNeedsDisplay()

    }
}
