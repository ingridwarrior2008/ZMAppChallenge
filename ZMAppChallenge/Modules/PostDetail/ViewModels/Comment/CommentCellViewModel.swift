//
//  CommentCellViewModel.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation

protocol CommentViewModelProtocol {
    var name: String { get }
    var email: String { get }
    var body: String { get }
}

class CommentCellViewModel: CommentViewModelProtocol {
    
    var name: String
    var email: String
    var body: String
    
    init(commetModel: Comment) {
        name = commetModel.name
        email = commetModel.email
        body = commetModel.body
    }
}

