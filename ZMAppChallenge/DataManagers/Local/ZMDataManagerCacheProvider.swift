//
//  ZMDataManagerCacheProvider.swift
//  ZMAppChallenge
//
//  Created by Cris on 11/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation
import RealmSwift
import os.log

protocol ZMDataManagerRealmProvider: ZMDataManagerCacheProtocol {
    func fetch<T: Object>(classType: T.Type) throws -> [T]
}

class ZMDataManagerCacheProvider: ZMDataManagerRealmProvider {
    
    let realm: Realm?
    
    init() {
        realm = try? Realm()
    }
    
    func saveObject<T>(object: T) {
        if let objectModel = object as? Object {
            do {
                try realm?.write {
                    realm?.add(objectModel)
                }
            } catch {
                os_log("Error when trying to save object", type: .error)
            }
        }
    }
    
    func saveObjects<T>(objects: [T]) {
        if let objectModels = objects as? [Object] {
            do {
                try realm?.write {
                    realm?.add(objectModels)
                }
            } catch {
                os_log("Error when trying to save objects", type: .error)
            }
        }
    }
    
    func deleteObject<T>(object: T) {
        if let objectModel = object as? Object {
            do {
                try realm?.write {
                    realm?.delete(objectModel)
                }
            } catch {
                os_log("Error when trying to delete object", type: .error)
            }
        }
    }
    
    func fetch<T: Object>(classType: T.Type) throws -> [T] {
        guard let array = realm?.objects(T.self) else { return [T]() }
        return Array(array)
    }
    
    func deleteAll() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch {
            os_log("Error when trying to delete all objects", type: .error)
        }
    }
}
