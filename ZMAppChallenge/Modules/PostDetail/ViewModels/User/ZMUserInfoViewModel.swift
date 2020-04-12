//
//  ZMUserInfoViewModel.swift
//  ZMAppChallenge
//
//  Created by Cris on 9/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

protocol ZMUserViewModelProtocol {
    var name: String { get }
    var email: String { get }
    var phone: String { get }
    var website: NSAttributedString { get }
}

class ZMUserViewModel: ZMUserViewModelProtocol {
    
    var name: String
    var email: String
    var phone: String
    var website: NSAttributedString
    
    init(userModel: ZMUser) {
        name = userModel.name
        email = userModel.email
        phone = userModel.phone
        
        var linkattributes: [NSAttributedString.Key: Any]?
        if let URL = URL(string: userModel.website) {
            linkattributes = [NSAttributedString.Key.link: URL]
        }
        
        website = NSAttributedString(string: userModel.website, attributes: linkattributes)
    }
}
