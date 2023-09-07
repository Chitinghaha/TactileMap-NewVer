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
        let minHeight: Double = self.gridModels.map { $0.y }.min() ?? 1.0
        let minWidth: Double = self.gridModels.map { $0.x }.min() ?? 1.0

        let totalHeight = maxHeight - minHeight
        let totalWidth = maxWidth - minWidth
        
        self.gridModels.forEach {
            let x = (($0.x - minWidth) / totalWidth) * view.frame.width
            let y = (($0.y - minHeight) / totalHeight) * view.frame.height
            let width = ($0.width / totalWidth) * view.frame.width
            let height = ($0.height / totalHeight) * view.frame.height
            
            let frame = CGRect(x: x, y: y, width: width, height: height)
            let view = PathTrainingViewGridCellView(frameRect: frame, color: UIColor(hex: $0.color), name: $0.name)
            rectangles.append(view)
        }
        
        return rectangles
    }
}
