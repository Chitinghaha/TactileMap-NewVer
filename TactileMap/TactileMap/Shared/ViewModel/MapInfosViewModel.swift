//
//  MapInfosViewModel.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/25.
//

import Foundation


class MapInfosViewModel {
    
    static let shared = MapInfosViewModel()
    
    var allMapsInfo: MultiMapInfoListModel
    
    var myMapsInfo: [SingleMapInfoModel] { get {
        var myMapsInfo: [SingleMapInfoModel] = []
        
        self.allMapsInfo.contents.forEach { mapList in
            mapList.infos.forEach {
                if (self.favoriteMaps.mapNames.contains($0.mapName)) {
                    myMapsInfo.append($0)
                }
            }
        }
        
        return myMapsInfo
    }}
    
    var favoriteMaps: FavoriteMaps
    
    init() {
        self.allMapsInfo = FileReadWriteService.shared.getAllMapInfomation()
        
        self.favoriteMaps = FileReadWriteService.shared.readFavoritesJson() ?? FavoriteMaps(mapNames: [])
    }
    
    func getMapLists(withClock: Bool, canSetFavorite: Bool) -> MultiMapInfoListModel  {
        var lists = self.allMapsInfo
        
        for i in 0..<lists.contents.count {
            for j in 0..<lists.contents[i].infos.count {
                let isFavorite = self.favoriteMaps.mapNames.contains(lists.contents[i].infos[j].mapName)
                
                lists.contents[i].infos[j].updateFavorite(favoriteEnabled: canSetFavorite, isFavorite: isFavorite)
            }
        }
        
        return lists
    }
    
    
    func getMapsFake(withClock: Bool, canSetFavorite: Bool) -> [SingleMapInfoModel] {
        let maps: [SingleMapInfoModel] = [
            SingleMapInfoModel(
                mapName: "tmpMap1",
                title: "資電",
                description: withClock ? "20230808" : "胡吃海喝",
                descriptionIconName: withClock ? "1" : "",
                favoriteEnabled: canSetFavorite,
                isFavorite: Bool.random()
            ),
            SingleMapInfoModel(
                mapName: "tmpMap2",
                title: "台達",
                description: withClock ? "20230808" : "胡吃海喝",
                descriptionIconName: withClock ? "1" : "",
                favoriteEnabled: canSetFavorite,
                isFavorite: Bool.random()
            ),
            SingleMapInfoModel(
                mapName: "tmpMap3",
                title: "物理",
                description: withClock ? "20230808" : "胡吃海喝",
                descriptionIconName: withClock ? "1" : "",
                favoriteEnabled: canSetFavorite,
                isFavorite: Bool.random()
            ),
            SingleMapInfoModel(
                mapName: "tmpMap1",
                title: "人社",
                description: withClock ? "20230808" : "胡吃海喝",
                descriptionIconName: withClock ? "1" : "",
                favoriteEnabled: canSetFavorite,
                isFavorite: Bool.random()
            ),
            SingleMapInfoModel(
                mapName: "tmpMap1",
                title: "testTitle1",
                description: withClock ? "20230808" : "胡吃海喝",
                descriptionIconName: withClock ? "1" : "",
                favoriteEnabled: canSetFavorite,
                isFavorite: Bool.random()
            )
        ]
        
        return maps
    }
    
    func getMapListsFake(withClock: Bool, canSetFavorite: Bool) -> MultiMapInfoListModel {
        
        let mapInfoListModels: MultiMapInfoListModel = MultiMapInfoListModel(
            contents: [
                MapInfoListModel(
                    title: "學餐",
                    infos: [
                        SingleMapInfoModel(
                            mapName: "tmpMap1",
                            title: "小吃部",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            favoriteEnabled: canSetFavorite,
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            mapName: "tmpMap2",
                            title: "風雲",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            favoriteEnabled: canSetFavorite,
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            mapName: "tmpMap3",
                            title: "水木",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            favoriteEnabled: canSetFavorite,
                            isFavorite: Bool.random()
                            
                        ),
                        SingleMapInfoModel(
                            mapName: "tmpMap1",
                            title: "人社",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            favoriteEnabled: canSetFavorite,
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            mapName: "tmpMap1",
                            title: "testTitle1",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            favoriteEnabled: canSetFavorite,
                            isFavorite: Bool.random())
                    ]
                ),
                MapInfoListModel(
                    title: "系館",
                    infos: [
                        SingleMapInfoModel(
                            mapName: "tmpMap1",
                            title: "資電",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            favoriteEnabled: canSetFavorite,
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            mapName: "tmpMap2",
                            title: "台達",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            favoriteEnabled: canSetFavorite,
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            mapName: "tmpMap3",
                            title: "物理",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            favoriteEnabled: canSetFavorite,
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            mapName: "tmpMap1",
                            title: "人社",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            favoriteEnabled: canSetFavorite,
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            mapName: "tmpMap1",
                            title: "testTitle1",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            favoriteEnabled: canSetFavorite,
                            isFavorite: Bool.random()
                        )
                    ]
                ),
                MapInfoListModel(
                    title: "常用區域",
                    infos: [
                        SingleMapInfoModel(
                            mapName: "tmpMap1",
                            title: "小吃部",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            favoriteEnabled: canSetFavorite,
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            mapName: "tmpMap2",
                            title: "資電館",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            favoriteEnabled: canSetFavorite,
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            mapName: "tmpMap3",
                            title: "水木",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            favoriteEnabled: canSetFavorite,
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            mapName: "tmpMap1",
                            title: "人社",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            favoriteEnabled: canSetFavorite,
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            mapName: "tmpMap1",
                            title: "testTitle1",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            favoriteEnabled: canSetFavorite,
                            isFavorite: Bool.random()
                        )
                    ]
                )
            ]
        )
        
        return mapInfoListModels
    }
    
}
