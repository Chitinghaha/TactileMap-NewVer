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
    
    init(frameRect: CGRect, color: UIColor, name: String) {
        
        self.frameRect = frameRect
        self.color = color
        self.name = name

        super.init(frame: frameRect)

        self.backgroundColor = self.color


        self.label.text = name
        self.label.textAlignment = .center

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
