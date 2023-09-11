//
//  MapInfosViewModel.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/25.
//

import Foundation
import Combine

class MapInfosViewModel {
    
    let throttleInterval: TimeInterval = 2.0
    
    static let shared = MapInfosViewModel()
    
    @Published var mapInfoLists: MultiMapInfoListModel
    
    var allMapsInfo: [SingleMapInfoModel] { get {
        self.mapInfoLists.contents.flatMap {
            $0.infos
        }
    }}
    
    @Published var favoriteMaps: [FavoriteMap]
        
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        self.mapInfoLists = FileReadWriteService.shared.getAllMapInfomation()
        
        self.favoriteMaps = FavoriteMapDataService.shared.fetchAll()
        
        self.setupBiding()
        
        for i in 0..<self.mapInfoLists.contents.count {
            for j in 0..<self.mapInfoLists.contents[i].infos.count {
                let isFavorite = self.favoriteMaps.contains { $0.mapTitle == self.mapInfoLists.contents[i].infos[j].title }
                
                self.mapInfoLists.contents[i].infos[j].updateFavorite(isFavorite: isFavorite)
            }
        }
    }
    
    func setupBiding() {
        self.$favoriteMaps
//            .print("favoriteMaps sink:")
            .sink {
                for i in 0..<self.mapInfoLists.contents.count {
                    for j in 0..<self.mapInfoLists.contents[i].infos.count {
                        let isFavorite = $0.contains { $0.mapTitle == self.mapInfoLists.contents[i].infos[j].title }
                        
                        self.mapInfoLists.contents[i].infos[j].updateFavorite(isFavorite: isFavorite)
                    }
                }
            }
            .store(in: &cancellable)
    }
    
    func updateFavoriteMaps(mapTitle: String, isFavorite: Bool) {
        if (isFavorite) {
            if (!self.favoriteMaps.contains{ $0.mapTitle == mapTitle }) {
                let newFavorite = FavoriteMap(context: FavoriteMapDataService.shared.context)
                newFavorite.mapTitle = mapTitle
                self.favoriteMaps.append(newFavorite)
                FavoriteMapDataService.shared.create(entity: newFavorite)
                
            }
        }
        else {
            if let favorite = self.favoriteMaps.first(where: { favoriteMap in
                favoriteMap.mapTitle == mapTitle
            }) {
                self.favoriteMaps.removeAll{ favoriteMap in
                    favoriteMap.mapTitle == mapTitle
                }
                FavoriteMapDataService.shared.delete(entity: favorite)
            }
        }
    }
    
    func getMyMapList() -> [SingleMapInfoModel] {
        var myMapsInfo: [SingleMapInfoModel] = []
        
        self.mapInfoLists.contents.forEach { mapList in
            mapList.infos.forEach { info in
                if (self.favoriteMaps.contains { $0.mapTitle == info.title }) {
                    myMapsInfo.append(info)
                }
            }
        }
        
        for i in 0..<myMapsInfo.count {
            myMapsInfo[i].updateFavorite(isFavorite: true)
        }
        
        return myMapsInfo
    }
    
    func getMapLists(withClock: Bool, canSetFavorite: Bool) -> MultiMapInfoListModel  {
        var lists = self.mapInfoLists
        
        for i in 0..<lists.contents.count {
            for j in 0..<lists.contents[i].infos.count {
                let isFavorite = self.favoriteMaps.contains { $0.mapTitle == lists.contents[i].infos[j].title }
                
                lists.contents[i].infos[j].updateFavorite(isFavorite: isFavorite)
            }
        }
        
        return lists
    }
    
    
    func getMapsFake(withClock: Bool, canSetFavorite: Bool) -> [SingleMapInfoModel] {
        let maps: [SingleMapInfoModel] = [
            SingleMapInfoModel(
                imageName: "tmpMap1",
                title: "資電",
                description: withClock ? "20230808" : "胡吃海喝",
                descriptionIconName: withClock ? "1" : "",
                
                isFavorite: Bool.random()
            ),
            SingleMapInfoModel(
                imageName: "tmpMap2",
                title: "台達",
                description: withClock ? "20230808" : "胡吃海喝",
                descriptionIconName: withClock ? "1" : "",
                
                isFavorite: Bool.random()
            ),
            SingleMapInfoModel(
                imageName: "tmpMap3",
                title: "物理",
                description: withClock ? "20230808" : "胡吃海喝",
                descriptionIconName: withClock ? "1" : "",
                
                isFavorite: Bool.random()
            ),
            SingleMapInfoModel(
                imageName: "tmpMap1",
                title: "人社",
                description: withClock ? "20230808" : "胡吃海喝",
                descriptionIconName: withClock ? "1" : "",
                
                isFavorite: Bool.random()
            ),
            SingleMapInfoModel(
                imageName: "tmpMap1",
                title: "testTitle1",
                description: withClock ? "20230808" : "胡吃海喝",
                descriptionIconName: withClock ? "1" : "",
                
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
                            imageName: "tmpMap1",
                            title: "小吃部",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            imageName: "tmpMap2",
                            title: "風雲",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            imageName: "tmpMap3",
                            title: "水木",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            
                            isFavorite: Bool.random()
                            
                        ),
                        SingleMapInfoModel(
                            imageName: "tmpMap1",
                            title: "人社",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            imageName: "tmpMap1",
                            title: "testTitle1",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            
                            isFavorite: Bool.random())
                    ]
                ),
                MapInfoListModel(
                    title: "系館",
                    infos: [
                        SingleMapInfoModel(
                            imageName: "tmpMap1",
                            title: "資電",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            imageName: "tmpMap2",
                            title: "台達",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            imageName: "tmpMap3",
                            title: "物理",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            imageName: "tmpMap1",
                            title: "人社",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            imageName: "tmpMap1",
                            title: "testTitle1",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            
                            isFavorite: Bool.random()
                        )
                    ]
                ),
                MapInfoListModel(
                    title: "常用區域",
                    infos: [
                        SingleMapInfoModel(
                            imageName: "tmpMap1",
                            title: "小吃部",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            imageName: "tmpMap2",
                            title: "資電館",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            imageName: "tmpMap3",
                            title: "水木",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            imageName: "tmpMap1",
                            title: "人社",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            
                            isFavorite: Bool.random()
                        ),
                        SingleMapInfoModel(
                            imageName: "tmpMap1",
                            title: "testTitle1",
                            description: withClock ? "20230808" : "胡吃海喝",
                            descriptionIconName: withClock ? "1" : "",
                            
                            isFavorite: Bool.random()
                        )
                    ]
                )
            ]
        )
        
        return mapInfoListModels
    }
    
}
