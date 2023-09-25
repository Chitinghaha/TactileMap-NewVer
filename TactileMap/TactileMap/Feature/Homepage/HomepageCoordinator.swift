//
//  HomepageCoordinator.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/30.
//

import Foundation

protocol HomepageCoordinator: Coordinator, MapInfoListCollectionViewCoordinator {
    func goToMapDetail(with mapInfo: Map)
    func backToHomePage()
}
