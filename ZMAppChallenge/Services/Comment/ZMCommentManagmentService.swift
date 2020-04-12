//
//  ZMCommentManagmentService.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class ZMCommentManagmentService: ZMNetworkManagmentService {
    
    var networkManager: ZMDataManagerNetworkProviderProtocol
    
    init(networkManager: ZMDataManagerNetworkProviderProtocol = ZMDataManagerNetworkProvider()) {
        self.networkManager = networkManager
    }
    
    func loadComments(with id: Int, completion: @escaping ([ZMComment], ZMAPIErrorType?) -> ()) {
        let commentPath = String(format: ZMRoute.getComments.value, "\(id)")
        let postBuilder = ZMNetworkBuilder(path: commentPath,
                                           httpMethod: .get,
                                           parameters: nil)
        
        networkManager.execute(classType: [ZMComment].self, networkParameters: postBuilder) { (result, error) in
            if let commentResult = result {
                completion(commentResult, nil)
            } else {
                completion([ZMComment](), error)
            }
        }
    }
}
