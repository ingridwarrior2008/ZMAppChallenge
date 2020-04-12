//
//  ZMDataManagerDatabaseProvider.swift
//  ZMAppChallenge
//
//  Created by Cris on 11/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation
import RealmSwift

protocol ZMDataManagerRealmProvider: ZMDataManagerCacheProtocol {
    func fetch<T: Object>(classType: T.Type) throws -> [T]
}

class ZMDataManagerCacheProvider: ZMDataManagerRealmProvider {
    
    let realm: Realm?
    
    init() {
      realm = try? Realm()
    }
    
    func saveObject<T>(object: T) throws {
        if let objectModel = object as? Object {
            try realm?.write {
                realm?.add(objectModel)
            }
        }
    }
    
    func saveObjects<T>(objects: [T]) throws {
        if let objectModels = objects as? [Object] {
            try realm?.write {
                realm?.add(objectModels)
            }
        }
    }
    
    func deleteObject<T>(object: T) throws {
        if let objectModel = object as? Object {
            try realm?.write {
                realm?.delete(objectModel)
            }
        }
    }
    
    func fetch<T: Object>(classType: T.Type) throws -> [T] {
        guard let array = realm?.objects(T.self) else { return [T]() }
        return Array(array)
    }
    
    func deleteAll() throws {
        try realm?.write {
          realm?.deleteAll()
        }
    }
}
