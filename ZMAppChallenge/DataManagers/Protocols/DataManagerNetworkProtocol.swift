//
//  DataManagerNetworkProtocol.swift
//  ZMAppChallenge
//
//  Created by Cris on 9/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation

protocol DataManagerNetworkProtocol {
    var baseURL: URL? { get }
}

enum HttpMethod: String {
    case get
    case post
    case put
    case delete
}

enum Route: String {
    case getPosts = "/posts"
    case getUser = "/users/%@"
    case getComments = "/posts/%@/comments"
    
    var value: String {
        return rawValue
    }
}

protocol DataManagerNetworkParameters {
    var path: String { get set }
    var httpMethod: HttpMethod { get set }
    var parameters: [String : Any]? { get set }
}

protocol NetworkManagmentService {
    var networkManager: DataManagerNetworkProviderProtocol { get }
}

protocol DataManagerNetworkProviderProtocol {
    func execute<T: Decodable>(classType: T.Type, networkParameters: DataManagerNetworkParameters, completion:  @escaping (T?, APIErrorType?) -> ())
}
