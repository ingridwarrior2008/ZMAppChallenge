//
//  NetworkBuilder.swift
//  ZMAppChallenge
//
//  Created by Cris on 9/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

struct NetworkBuilder: DataManagerNetworkParameters {
    var path: String
    var httpMethod: HttpMethod
    var parameters: [String : Any]?
}
