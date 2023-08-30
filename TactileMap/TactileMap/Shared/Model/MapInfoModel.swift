//
//  SingleMapInfoModel.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/23.
//

import Foundation

struct FavoriteMaps: Hashable, Codable {
    let mapNames: [String]
}

struct SingleMapInfoModel: Hashable, Decodable {
    let imageName: String
    let title: String
    let description: String
    let descriptionIconName: String
    var favoriteEnabled: Bool?
    var isFavorite: Bool?
    
    mutating func updateFavorite(favoriteEnabled: Bool, isFavorite: Bool) {
        self.favoriteEnabled = favoriteEnabled
        self.isFavorite = isFavorite
    }
}

struct MapInfoListModel: Hashable, Decodable {
    let title: String
    var infos: [SingleMapInfoModel]
}

struct MultiMapInfoListModel: Hashable, Decodable {
    var contents: [MapInfoListModel]
}
