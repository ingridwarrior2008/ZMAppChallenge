//
//  PostManagmentService.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class ZMPostManagmentService: ZMNetworkManagmentService {
    
    var networkManager: ZMDataManagerNetworkProviderProtocol
    
    init(networkManager: ZMDataManagerNetworkProviderProtocol = ZMDataManagerNetworkProvider()) {
        self.networkManager = networkManager
    }
    
    func loadPost(completion: @escaping ([ZMPost], ZMAPIErrorType?) -> ()) {
        
        let postBuilder = ZMNetworkBuilder(path: ZMRoute.getPosts.value,
                                           httpMethod: .get,
                                           parameters: nil)
        
        networkManager.execute(classType: [ZMPost].self, networkParameters: postBuilder) { (result, error) in
            if let postResult = result {
                completion(postResult, nil)
            } else {
                completion([ZMPost](), error)
            }
        }
    }
}
