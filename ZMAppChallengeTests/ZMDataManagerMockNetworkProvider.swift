//
//  ZMDataManagerMockNetworkProvider.swift
//  ZMAppChallenge
//
//  Created by Cris on 9/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation
@testable import ZMAppChallenge

class ZMDataManagerMockNetworkProvider: ZMDataManagerNetworkProviderProtocol {
    
    //MARK: - Properties
    let jsonFilePath: String
    
    init(_ jsonFile: String) {
        self.jsonFilePath = jsonFile
    }
    
    //MARK: - ZMDataManagerNetworkProviderProtocol
    
    func execute<T: Decodable>(classType: T.Type, networkParameters dataManagerParameters: ZMDataManagerNetworkParameters, completion: @escaping (T?, ZMAPIErrorType?) -> ()) {
        if let file = Bundle(for: type(of: self)).url(forResource: jsonFilePath, withExtension: "json") {
            do {
                let data = try Data(contentsOf: file)
                let parser = try JSONDecoder().decode(T.self, from: data)
                completion(parser, nil)
            } catch {
                completion(nil, ZMAPIErrorType.invalidData)
            }
        } else {
            completion(nil, ZMAPIErrorType.invalidData)
        }
    }
}
