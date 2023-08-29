//
//  HomepageViewModel.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/29.
//

import Foundation
import Combine

class HomepageViewModel {
    
    var mapInfoListModels: MultiMapInfoListModel
    
    init() {
        self.mapInfoListModels = MapInfosViewModel.shared.getMapLists(withClock: true, canSetFavorite: false)
        
    }
    
    
}
