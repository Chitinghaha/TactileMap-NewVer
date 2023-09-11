//
//  FavoriteMapDataService.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/9/11.
//

import Foundation
import CoreData
import UIKit

class FavoriteMapDataService: CoreDataService {
    typealias Entity = FavoriteMap
    
    static let shared = FavoriteMapDataService()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func create(entity: FavoriteMap) {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    func fetchAll() -> [FavoriteMap] {
        var FavoriteMaps = [FavoriteMap]()
        let request: NSFetchRequest<FavoriteMap> = FavoriteMap.fetchRequest()
        
        do {
            FavoriteMaps = try context.fetch(request)
        } catch {
            print("Error fetching FavoriteMaps: \(error)")
        }
        
        return FavoriteMaps
    }
    
    func update(entity: FavoriteMap) {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    func delete(entity: FavoriteMap) {
        context.delete(entity)
        
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
