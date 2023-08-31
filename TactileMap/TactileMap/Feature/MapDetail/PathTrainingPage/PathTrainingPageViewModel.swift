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
        
        let gridModels = self.gridModels
        
        gridModels.forEach {
            let frame = CGRect(x: $0.x * view.frame.width, y: $0.y * view.frame.height, width: $0.width * view.frame.width, height: $0.height * view.frame.height)
            let view = PathTrainingViewGridCellView(frameRect: frame, color: UIColor(hex: $0.color), name: $0.name)
            rectangles.append(view)
        }
        
        return rectangles
    }
}
