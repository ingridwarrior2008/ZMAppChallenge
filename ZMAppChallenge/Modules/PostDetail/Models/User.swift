//
//  User.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class User: Object, Codable {
    
    // MARK: - Properties
    dynamic var userId: Int = 0
    dynamic var name: String = ""
    dynamic var username: String = ""
    dynamic var email: String = ""
    dynamic var phone: String = ""
    dynamic var website: String = ""
    
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case name
        case username
        case email
        case phone
        case website
    }
    
    required init(from decoder: Decoder) throws {
        let decode = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try decode.decodeIfPresent(Int.self, forKey: .userId) ?? 0
        self.name = try decode.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.username = try decode.decodeIfPresent(String.self, forKey: .username) ?? ""
        self.email = try decode.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.phone = try decode.decodeIfPresent(String.self, forKey: .phone) ?? ""
        self.website = try decode.decodeIfPresent(String.self, forKey: .website) ?? ""
        super.init()
    }
    
    required init() {
        super.init()
    }
}
