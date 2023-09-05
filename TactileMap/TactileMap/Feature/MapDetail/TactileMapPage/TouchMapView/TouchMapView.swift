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
            AVSpeechSynthesizerService.shared.speak(content: rectangles[index].name)
            
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
            AVSpeechSynthesizerService.shared.speak(content: "室外區域")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedRectangleIndex = nil
    }
}
