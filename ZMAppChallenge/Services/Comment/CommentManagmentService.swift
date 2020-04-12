//
//  CommentManagmentService.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class CommentManagmentService: NetworkManagmentService {
    
    var networkManager: DataManagerNetworkProviderProtocol
    
    init(networkManager: DataManagerNetworkProviderProtocol = DataManagerNetworkProvider()) {
        self.networkManager = networkManager
    }
    
    func loadComments(with id: Int, completion: @escaping ([Comment], APIErrorType?) -> ()) {
        let commentPath = String(format: Route.getComments.value, "\(id)")
        let postBuilder = NetworkBuilder(path: commentPath,
                                           httpMethod: .get,
                                           parameters: nil)
        
        networkManager.execute(classType: [Comment].self, networkParameters: postBuilder) { (result, error) in
            if let commentResult = result {
                completion(commentResult, nil)
            } else {
                completion([Comment](), error)
            }
        }
    }
}
