//
//  MapDetailSideMenuViewModel.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/30.
//

import Foundation

class MapDetailSideMenuViewModel {
    var allMapInfo: [SingleMapInfoModel]
    var currentMap: SingleMapInfoModel
    
    init(currentMap: SingleMapInfoModel) {
        self.currentMap = currentMap
        self.allMapInfo = MapInfosViewModel.shared.allMapsInfo
    }
    
    
}
