//
//  FileReadWriteService.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/25.
//

import Foundation

class FileService {
    static let shared = FileService()
    
    func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
//    func readFavoritesJson() -> FavoriteMaps? {
//        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
//                                                            in: .userDomainMask).first {
//            let pathWithFilename = documentDirectory.appendingPathComponent("FavoriteMaps.json")
//
//            do {
//                let savedJSONData = try Data(contentsOf: pathWithFilename)
//                let favoriteMaps = try? JSONDecoder().decode(FavoriteMaps.self, from: savedJSONData)
//
//                return favoriteMaps
//            }
//            catch {
//                _ = self.saveFavoritesJson(favorites: FavoriteMaps(mapNames: []))
//                print("read FavoritesJson failed, error: \(error)")
//            }
//        }
//
//        return nil
//    }
//
//    func saveFavoritesJson(favorites: FavoriteMaps) -> Bool{
//
//        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
//                                                            in: .userDomainMask).first {
//            let pathWithFilename = documentDirectory.appendingPathComponent("FavoriteMaps.json")
//
//            let jsonEncoder = JSONEncoder()
//
//            jsonEncoder.outputFormatting = .prettyPrinted
//              // 將 JsonData 寫入 JsonURL = Stickers/sticker.json
//            do {
//
//                let jsonData = try jsonEncoder.encode(favorites)
//                try jsonData.write(to: pathWithFilename)
//                return true
//            } catch {
//                print("save FavoritesJson failed, error: \(error)")
//                return false
//            }
//        }
//        else {
//            return false
//        }
//    }
    
}
