//
//  MapInfoDataStore.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/9/22.
//
import Combine

class MapInfoDataStore {
    
    static let shared = MapInfoDataStore(
        mapLists: FileService.shared.load("AllMapsInfomation.json")
    )
    
    var mapLists: [MapList]

    var allMapsInfo: [Map] { get {
        self.mapLists.flatMap {
            $0.infos
        }
    }}
    
    var didUpdateMap = PassthroughSubject<Map, Never>()
    
    init(mapLists: [MapList]) {
        var mapLists = mapLists
        let favorites: [String] = FavoriteMapDataService.shared.fetchAll().compactMap { $0.mapTitle }

        for j in 0..<mapLists.count {
            for i in 0..<mapLists[j].infos.count {
                if (favorites.contains { $0 == mapLists[j].infos[i].title }) {
                    mapLists[j].infos[i].updateFavorite(isFavorite: true)
                }
                else {
                    mapLists[j].infos[i].updateFavorite(isFavorite: false)
                }
            }
        }
        
        self.mapLists = mapLists
    }
    
    func getFavoriteMaps() -> [Map] {
        return self.allMapsInfo.filter { map in
            map.isFavorite ?? false
        }
    }
    
    func updateFavoriteMaps(mapTitle: String, isFavorite: Bool) {
        let favorites = FavoriteMapDataService.shared.fetchAll()
        
        if (isFavorite) {
            if (!favorites.contains{ $0.mapTitle == mapTitle }) {
                let newFavorite = FavoriteMap(context: FavoriteMapDataService.shared.context)
                newFavorite.mapTitle = mapTitle
                FavoriteMapDataService.shared.create(entity: newFavorite)
            }
        }
        else {
            if let favorite = favorites.first(where: { $0.mapTitle == mapTitle }) {
                FavoriteMapDataService.shared.delete(entity: favorite)
            }
        }
        
        for i in 0..<self.mapLists.count {
            if let index = self.mapLists[i].infos.firstIndex(where: { $0.title == mapTitle }) {
                self.mapLists[i].infos[index].updateFavorite(isFavorite: isFavorite)
                self.didUpdateMap.send(self.mapLists[i].infos[index])
                return
            }
        }
    }
    
}


