//
//  SingleMapInfoModel.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/23.
//

import Foundation

struct Map: Hashable, Decodable {
    let id: Int
    let imageName: String
    let title: String
    let description: String
    let descriptionIconName: String
    var isFavorite: Bool?
    
    mutating func updateFavorite(isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
}

struct MapList: Hashable, Decodable {
    let id: Int
    let title: String
    var infos: [Map]
}
