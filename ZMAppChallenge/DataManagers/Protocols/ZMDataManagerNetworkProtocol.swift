//
//  ZMDataManagerNetworkProtocol.swift
//  ZMAppChallenge
//
//  Created by Cris on 9/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation

protocol ZMDataManagerNetworkProtocol {
    var baseURL: URL? { get }
}

enum ZMHttpMethod: String {
    case get
    case post
    case put
    case delete
}

enum ZMRoute: String {
    case getPosts = "/posts"
    case getUser = "/users/%@"
    case getComments = "/posts/%@/comments"
    
    var value: String {
        return rawValue
    }
}

protocol ZMDataManagerNetworkParameters {
    var path: String { get set }
    var httpMethod: ZMHttpMethod { get set }
    var parameters: [String : Any]? { get set }
}

protocol ZMNetworkManagmentService {
    var networkManager: ZMDataManagerNetworkProviderProtocol { get }
}

protocol ZMDataManagerNetworkProviderProtocol {
    func execute<T: Decodable>(classType: T.Type, networkParameters: ZMDataManagerNetworkParameters, completion:  @escaping (T?, ZMAPIErrorType?) -> ())
}
