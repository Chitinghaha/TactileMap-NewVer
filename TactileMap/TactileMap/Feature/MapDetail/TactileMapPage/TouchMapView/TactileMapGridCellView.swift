//
//  TactileMapGridModel.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/30.
//

import Foundation
import UIKit
import Hue

class TactileMapGridCellView: UIView {
    let frameRect: CGRect
    let color: UIColor
    let name: String
    let label = UILabel()
    let mapDescription: String?
    
    init(frameRect: CGRect, color: UIColor, name: String, description: String? = nil) {
        self.frameRect = frameRect
        self.color = color
        self.name = name
        self.mapDescription = description
        
        super.init(frame: frameRect)
        
        if (!self.name.contains("走道")) {
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.borderWidth = 3
        }
        
        self.backgroundColor = self.color
        self.label.text = name
        self.label.textAlignment = .center
        self.label.textColor = .white
        self.label.isAccessibilityElement = false
//        self.label.textColor = self.color.complementaryColor()
        
        self.addSubview(label)

        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.font = UIFont.systemFont(ofSize: 24)
        NSLayoutConstraint.activate([
            self.label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
