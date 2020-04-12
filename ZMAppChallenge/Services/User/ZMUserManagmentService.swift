//
//  ZMUserManagmentService.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class ZMUserManagmentService: ZMNetworkManagmentService {
    
    var networkManager: ZMDataManagerNetworkProviderProtocol
    
    init(networkManager: ZMDataManagerNetworkProviderProtocol = ZMDataManagerNetworkProvider()) {
        self.networkManager = networkManager
    }
    
    func loadUser(with id: Int, completion: @escaping (ZMUser?, ZMAPIErrorType?) -> ()) {
        
        let userPath = String(format: ZMRoute.getUser.value, "\(id)")
        let postBuilder = ZMNetworkBuilder(path: userPath,
                                           httpMethod: .get,
                                           parameters: nil)
        
        networkManager.execute(classType: ZMUser.self, networkParameters: postBuilder) { (result, error) in
            completion(result, error)
        }
    }
}
