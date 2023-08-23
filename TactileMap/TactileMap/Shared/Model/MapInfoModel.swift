//
//  SingleMapInfoModel.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/23.
//

import Foundation

struct SingleMapInfoModel: Hashable {
    let imageName: String
    let title: String
    let description: String
    let descriptionIconName: String
    let favoriteEnabled: Bool
    let isFavorite: Bool
}

struct MapInfoListModel: Hashable {
    let title: String
    let infos: [SingleMapInfoModel]
}

struct multiMapInfoListModel: Hashable {
    let contents: [MapInfoListModel]
}
