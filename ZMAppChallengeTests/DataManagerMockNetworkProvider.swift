//
//  DataManagerMockNetworkProvider.swift
//  ZMAppChallenge
//
//  Created by Cris on 9/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation
@testable import ZMAppChallenge

class DataManagerMockNetworkProvider: DataManagerNetworkProviderProtocol {
    
    //MARK: - Properties
    let jsonFilePath: String
    
    init(_ jsonFile: String) {
        self.jsonFilePath = jsonFile
    }
    
    //MARK: - DataManagerNetworkProviderProtocol
    
    func execute<T: Decodable>(classType: T.Type, networkParameters dataManagerParameters: DataManagerNetworkParameters, completion: @escaping (T?, APIErrorType?) -> ()) {
        if let file = Bundle(for: type(of: self)).url(forResource: jsonFilePath, withExtension: "json") {
            do {
                let data = try Data(contentsOf: file)
                let parser = try JSONDecoder().decode(T.self, from: data)
                completion(parser, nil)
            } catch {
                completion(nil, APIErrorType.invalidData)
            }
        } else {
            completion(nil, APIErrorType.invalidData)
        }
    }
}
