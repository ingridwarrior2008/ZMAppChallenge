//
//  UserManagmentService.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class UserManagmentService: NetworkManagmentService {
    
    var networkManager: DataManagerNetworkProviderProtocol
    
    init(networkManager: DataManagerNetworkProviderProtocol = DataManagerNetworkProvider()) {
        self.networkManager = networkManager
    }
    
    func loadUser(with id: Int, completion: @escaping (User?, APIErrorType?) -> ()) {
        
        let userPath = String(format: Route.getUser.value, "\(id)")
        let postBuilder = NetworkBuilder(path: userPath,
                                           httpMethod: .get,
                                           parameters: nil)
        
        networkManager.execute(classType: User.self, networkParameters: postBuilder) { (result, error) in
            completion(result, error)
        }
    }
}
