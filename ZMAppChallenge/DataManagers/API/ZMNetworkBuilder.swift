//
//  ZMNetworkBuilder.swift
//  ZMAppChallenge
//
//  Created by Cris on 9/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

struct ZMNetworkBuilder: ZMDataManagerNetworkParameters {
    var path: String
    var httpMethod: ZMHttpMethod
    var parameters: [String : Any]?
}
