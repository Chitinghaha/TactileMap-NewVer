//
//  SingleMapInfoModel.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/23.
//

import Foundation

struct FavoriteMapID: Hashable, Codable {
    let mapID: [Int]
    let mapListID: Int
}

struct FavoritesMapModel: Hashable, Codable {
    let contents: [FavoriteMapID]
}

struct SingleMapInfoModel: Hashable, Decodable {
    let imageName: String
    let title: String
    let description: String
    let descriptionIconName: String
    let favoriteEnabled: Bool?
    let isFavorite: Bool?
    let mapID: Int
}

struct MapInfoListModel: Hashable, Decodable {
    let title: String
    let infos: [SingleMapInfoModel]
    let mapListID: Int
}

struct MultiMapInfoListModel: Hashable, Decodable {
    let contents: [MapInfoListModel]
}
