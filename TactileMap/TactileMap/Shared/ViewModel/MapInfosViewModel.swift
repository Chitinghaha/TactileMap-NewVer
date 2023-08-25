//
//  MapInfosViewModel.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/25.
//

import Foundation


class MapInfosViewModel {
    
    static let shared = MapInfosViewModel()
    
    var allMapsInfo: MultiMapInfoListModel?
    
    var myMapsInfo: [SingleMapInfoModel] { get {
        var myMapsInfo: [SingleMapInfoModel] = []
        
        if let allMapsInfo = self.allMapsInfo,
           let favorites = self.favorites {
            allMapsInfo.contents.forEach { mapList in
                if let favoriteList = favorites.contents.first(where: { $0.mapListID == mapList.mapListID })?.mapID {
                    mapList.infos.forEach {
                        if( favoriteList.contains( $0.mapID ) ) {
                            myMapsInfo.append($0)
                        }
                    }
                }
            }
        }
        
        return myMapsInfo
    }}
    
    var favorites: FavoritesMapModel?
    
    init() {
        self.allMapsInfo = FileReadWriteService.shared.getAllMapInfomation()
        
//        self.favorites = self.readFavoritesData()
    }
    
//    func readAllMapsInfo() -> MultiMapInfoListModel {
//        
//        
//    }
//    
//    func readFavoritesData() -> FavoritesMapModel {
//        
//    }
    
    func getMapsFake(withClock: Bool, canSetFavorite: Bool) -> [SingleMapInfoModel] {
        let maps: [SingleMapInfoModel] = [
            SingleMapInfoModel(imageName: "tmpMap1",
                               title: "資電",
                               description: withClock ? "20230808" : "胡吃海喝",
                               descriptionIconName: withClock ? "1" : "",
                               favoriteEnabled: canSetFavorite,
                               isFavorite: Bool.random(),
                               mapID: 1),
            SingleMapInfoModel(imageName: "tmpMap2",
                               title: "台達",
                               description: withClock ? "20230808" : "胡吃海喝",
                               descriptionIconName: withClock ? "1" : "",
                               favoriteEnabled: canSetFavorite,
                               isFavorite: Bool.random(),
                               mapID: 1),
            SingleMapInfoModel(imageName: "tmpMap3",
                               title: "物理",
                               description: withClock ? "20230808" : "胡吃海喝",
                               descriptionIconName: withClock ? "1" : "",
                               favoriteEnabled: canSetFavorite,
                               isFavorite: Bool.random(),
                               mapID: 1),
            SingleMapInfoModel(imageName: "tmpMap1",
                               title: "人社",
                               description: withClock ? "20230808" : "胡吃海喝",
                               descriptionIconName: withClock ? "1" : "",
                               favoriteEnabled: canSetFavorite,
                               isFavorite: Bool.random(),
                               mapID: 1),
            SingleMapInfoModel(imageName: "tmpMap1",
                               title: "testTitle1",
                               description: withClock ? "20230808" : "胡吃海喝",
                               descriptionIconName: withClock ? "1" : "",
                               favoriteEnabled: canSetFavorite,
                               isFavorite: Bool.random(),
                               mapID: 1)
        ]
        
        return maps
    }
    
    func getMapListsFake(withClock: Bool, canSetFavorite: Bool) -> MultiMapInfoListModel {
        
        let mapInfoListModels: MultiMapInfoListModel = MultiMapInfoListModel(
            contents: [
                MapInfoListModel(
                    title: "學餐",
                    infos: [
                        SingleMapInfoModel(imageName: "tmpMap1",
                                           title: "小吃部",
                                           description: withClock ? "20230808" : "胡吃海喝",
                                           descriptionIconName: withClock ? "1" : "",
                                           favoriteEnabled: canSetFavorite,
                                           isFavorite: Bool.random(),
                                           mapID: 1),
                        SingleMapInfoModel(imageName: "tmpMap2",
                                           title: "風雲",
                                           description: withClock ? "20230808" : "胡吃海喝",
                                           descriptionIconName: withClock ? "1" : "",
                                           favoriteEnabled: canSetFavorite,
                                           isFavorite: Bool.random(),
                                           mapID: 1),
                        SingleMapInfoModel(imageName: "tmpMap3",
                                           title: "水木",
                                           description: withClock ? "20230808" : "胡吃海喝",
                                           descriptionIconName: withClock ? "1" : "",
                                           favoriteEnabled: canSetFavorite,
                                           isFavorite: Bool.random(),
                                           mapID: 1),
                        SingleMapInfoModel(imageName: "tmpMap1",
                                           title: "人社",
                                           description: withClock ? "20230808" : "胡吃海喝",
                                           descriptionIconName: withClock ? "1" : "",
                                           favoriteEnabled: canSetFavorite,
                                           isFavorite: Bool.random(),
                                           mapID: 1),
                        SingleMapInfoModel(imageName: "tmpMap1",
                                           title: "testTitle1",
                                           description: withClock ? "20230808" : "胡吃海喝",
                                           descriptionIconName: withClock ? "1" : "",
                                           favoriteEnabled: canSetFavorite,
                                           isFavorite: Bool.random(),
                                           mapID: 1)
                    ],
                    mapListID: 1
                ),
                MapInfoListModel(
                    title: "系館",
                    infos: [
                        SingleMapInfoModel(imageName: "tmpMap1",
                                           title: "資電",
                                           description: withClock ? "20230808" : "胡吃海喝",
                                           descriptionIconName: withClock ? "1" : "",
                                           favoriteEnabled: canSetFavorite,
                                           isFavorite: Bool.random(),
                                           mapID: 1),
                        SingleMapInfoModel(imageName: "tmpMap2",
                                           title: "台達",
                                           description: withClock ? "20230808" : "胡吃海喝",
                                           descriptionIconName: withClock ? "1" : "",
                                           favoriteEnabled: canSetFavorite,
                                           isFavorite: Bool.random(),
                                           mapID: 1),
                        SingleMapInfoModel(imageName: "tmpMap3",
                                           title: "物理",
                                           description: withClock ? "20230808" : "胡吃海喝",
                                           descriptionIconName: withClock ? "1" : "",
                                           favoriteEnabled: canSetFavorite,
                                           isFavorite: Bool.random(),
                                           mapID: 1),
                        SingleMapInfoModel(imageName: "tmpMap1",
                                           title: "人社",
                                           description: withClock ? "20230808" : "胡吃海喝",
                                           descriptionIconName: withClock ? "1" : "",
                                           favoriteEnabled: canSetFavorite,
                                           isFavorite: Bool.random(),
                                           mapID: 1),
                        SingleMapInfoModel(imageName: "tmpMap1",
                                           title: "testTitle1",
                                           description: withClock ? "20230808" : "胡吃海喝",
                                           descriptionIconName: withClock ? "1" : "",
                                           favoriteEnabled: canSetFavorite,
                                           isFavorite: Bool.random(),
                                           mapID: 1)
                    ],
                    mapListID: 2
                ),
                MapInfoListModel(
                    title: "常用區域",
                    infos: [
                        SingleMapInfoModel(imageName: "tmpMap1",
                                           title: "小吃部",
                                           description: withClock ? "20230808" : "胡吃海喝",
                                           descriptionIconName: withClock ? "1" : "",
                                           favoriteEnabled: canSetFavorite,
                                           isFavorite: Bool.random(),
                                           mapID: 1),
                        SingleMapInfoModel(imageName: "tmpMap2",
                                           title: "資電館",
                                           description: withClock ? "20230808" : "胡吃海喝",
                                           descriptionIconName: withClock ? "1" : "",
                                           favoriteEnabled: canSetFavorite,
                                           isFavorite: Bool.random(),
                                           mapID: 1),
                        SingleMapInfoModel(imageName: "tmpMap3",
                                           title: "水木",
                                           description: withClock ? "20230808" : "胡吃海喝",
                                           descriptionIconName: withClock ? "1" : "",
                                           favoriteEnabled: canSetFavorite,
                                           isFavorite: Bool.random(),
                                           mapID: 1),
                        SingleMapInfoModel(imageName: "tmpMap1",
                                           title: "人社",
                                           description: withClock ? "20230808" : "胡吃海喝",
                                           descriptionIconName: withClock ? "1" : "",
                                           favoriteEnabled: canSetFavorite,
                                           isFavorite: Bool.random(),
                                           mapID: 1),
                        SingleMapInfoModel(imageName: "tmpMap1",
                                           title: "testTitle1",
                                           description: withClock ? "20230808" : "胡吃海喝",
                                           descriptionIconName: withClock ? "1" : "",
                                           favoriteEnabled: canSetFavorite,
                                           isFavorite: Bool.random(),
                                           mapID: 1)
                    ],
                    mapListID: 3
                )
            ]
        )
        
        return mapInfoListModels
    }
    
}
