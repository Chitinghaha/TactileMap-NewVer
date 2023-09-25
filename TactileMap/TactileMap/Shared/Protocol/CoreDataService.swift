//
//  CoreDataService.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/9/11.
//

import CoreData

protocol CoreDataService {
    associatedtype Entity: NSManagedObject
    
    func create(entity: Entity)
    func fetchAll() -> [Entity]
    func update(entity: Entity)
    func delete(entity: Entity)
}
