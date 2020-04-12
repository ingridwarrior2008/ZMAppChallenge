//
//  ZMCommentCellViewModel.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

protocol ZMCommentViewModelProtocol {
    var name: String { get }
    var email: String { get }
    var body: String { get }
}

class ZMCommentCellViewModel: ZMCommentViewModelProtocol {
    
    var name: String
    var email: String
    var body: String
    
    init(commetModel: ZMComment) {
        name = commetModel.name
        email = commetModel.email
        body = commetModel.body
    }
}

