//
//  ZMTableViewCellProtocol.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

protocol ZMTableViewCellProtocol {
    static var identifier: String { get }
}

extension ZMTableViewCellProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
