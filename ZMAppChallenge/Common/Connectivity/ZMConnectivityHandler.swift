//
//  ZMConnectivityHandler.swift
//  ZMAppChallenge
//
//  Created by Cris on 11/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation
import Reachability

class ZMConnectivityHandler {
    
    // MARK: - Properties
    
    class func isNetworkConnected() -> Bool {
        let reachability = try? Reachability()
        return reachability?.connection != .unavailable
    }
}
