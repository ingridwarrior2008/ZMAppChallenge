//
//  ViewModelServiceDelegate.swift
//  ZMAppChallenge
//
//  Created by Cris on 11/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation

protocol ViewModelServiceDelegate: class {
    func willServiceStart()
    func didServiceFinish()
    func didServiceFail(with error: APIErrorType)
}
