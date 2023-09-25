//
//  TactileMapGridViewModel.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/30.
//

import Foundation

class TactileMapGridViewModel {
    
    static let shared = TactileMapGridViewModel()
    
    func getGridModels(mapName: String) -> [TactileMapGridModel]{
        var gridModels: [TactileMapGridModel] = []
        
        do {
            if let url = Bundle.main.url(
                forResource: "Map_\(mapName)",
                withExtension: "json"
            ) {
                let data = try Data(contentsOf: url, options: .alwaysMapped)
                
                gridModels = try JSONDecoder().decode([TactileMapGridModel].self, from: data)
            }
            
        } catch {
            print("getAllMapInfomation failed, error :\(error)")
        }

        return gridModels
    }
    
}
