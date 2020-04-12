//
//  DataManagerDatabaseProtocol.swift
//  ZMAppChallenge
//
//  Created by Cris on 11/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation

protocol DataManagerCacheProtocol: class {
    func saveObject<T>(object: T)
    func saveObjects<T>(objects: [T])
    func deleteObject<T>(object: T)
    func deleteAll()
}
