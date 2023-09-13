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
        
        if (self.subviews.count == 0) {
            self.rectangles.forEach {
                self.addSubview($0)
                $0.accessibilityValue = $0.name
                $0.isAccessibilityElement = true
//                $0.accessibilityTraits.insert(.startsMediaSession)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        selectedRectangleIndex = rectangles.lastIndex { $0.frame.contains(location) }
        if let index = selectedRectangleIndex {
            if let description = rectangles[index].mapDescription,
               description.count > 0 {
                DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
                    UIAccessibility.post(notification: .announcement, argument: description)
                }
//                AVSpeechSynthesizerService.shared.speak(content: description)
            }
            else {
                DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
                    UIAccessibility.post(notification: .announcement, argument: "缺少\(self.rectangles[index].name)的相關描述")
                }
//                AVSpeechSynthesizerService.shared.speak(content: "缺少\(rectangles[index].name)的相關描述")

            }
            let view = self.rectangles[index]
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
        else {
            AVSpeechSynthesizerService.shared.speak(content: "超出地圖邊界")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedRectangleIndex = nil
    }
}
