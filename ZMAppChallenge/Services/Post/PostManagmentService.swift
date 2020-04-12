//
//  PostManagmentService.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class PostManagmentService: NetworkManagmentService {
    
    var networkManager: DataManagerNetworkProviderProtocol
    
    init(networkManager: DataManagerNetworkProviderProtocol = DataManagerNetworkProvider()) {
        self.networkManager = networkManager
    }
    
    func loadPost(completion: @escaping ([Post], APIErrorType?) -> ()) {
        
        let postBuilder = NetworkBuilder(path: Route.getPosts.value,
                                           httpMethod: .get,
                                           parameters: nil)
        
        networkManager.execute(classType: [Post].self, networkParameters: postBuilder) { (result, error) in
            if let postResult = result {
                completion(postResult, nil)
            } else {
                completion([Post](), error)
            }
        }
    }
}
