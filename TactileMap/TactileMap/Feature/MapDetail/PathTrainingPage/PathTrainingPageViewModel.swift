//
//  PathTrainingPageViewModel.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/30.
//

import Foundation
import UIKit
import Combine

class PathTrainingPageViewModel {
    var mapInfo: SingleMapInfoModel
    
    var gridModels: [TactileMapGridModel]{ get {
        TactileMapGridViewModel.shared.getGridModels(mapName: self.mapInfo.title)
    }}
    
    init(mapInfo: SingleMapInfoModel) {
        self.mapInfo = mapInfo
    }
    
    func getRectangleViews(in view: UIView) -> [PathTrainingViewGridCellView]{
        var rectangles: [PathTrainingViewGridCellView] = []
        
        let maxHeight: Double = self.gridModels.map { $0.height + $0.y }.max() ?? 1.0
        let maxWidth: Double = self.gridModels.map { $0.width + $0.x }.max() ?? 1.0

        self.gridModels.forEach {
            let x = ($0.x / maxWidth) * view.frame.width
            let y = ($0.y / maxHeight) * view.frame.height
            let width = ($0.width / maxWidth) * view.frame.width
            let height = ($0.height / maxHeight) * view.frame.height
            
            let frame = CGRect(x: x, y: y, width: width, height: height)
            let view = PathTrainingViewGridCellView(frameRect: frame, color: UIColor(hex: $0.color), name: $0.name)
            rectangles.append(view)
        }
        
        return rectangles
    }
}
