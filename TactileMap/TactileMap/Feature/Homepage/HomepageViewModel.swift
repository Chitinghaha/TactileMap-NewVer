//
//  HomepageViewModel.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/29.
//

import Foundation
import Combine

class HomepageViewModel {
    
    @Published var mapInfoListModels: MultiMapInfoListModel = MultiMapInfoListModel(contents: [])
    var viewWillApear = PassthroughSubject<Void, Never>()
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        
        self.viewWillApear
            .sink {
                self.mapInfoListModels = MapInfosViewModel.shared.mapInfoLists
//                self.mapInfoListModels = MapInfosViewModel.shared.getMapListsFake(withClock: true, canSetFavorite: true)

            }
            .store(in: &cancellable)
        
    }
}
