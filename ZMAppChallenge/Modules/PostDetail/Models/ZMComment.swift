//
//  ZMComment.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class ZMComment: Object, Codable {
    
    // MARK: - Properties
    dynamic var commentID: Int = 0
    dynamic var postId: Int = 0
    dynamic var name: String = ""
    dynamic var email: String = ""
    dynamic var body: String = ""
    
    enum CodingKeys: String, CodingKey {
        case commentID = "id"
        case postId
        case name
        case email
        case body
    }
    
    required init(from decoder: Decoder) throws {
        let decode = try decoder.container(keyedBy: CodingKeys.self)
        self.commentID = try decode.decodeIfPresent(Int.self, forKey: .commentID) ?? 0
        self.postId = try decode.decodeIfPresent(Int.self, forKey: .postId) ?? 0
        self.name = try decode.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.email = try decode.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.body = try decode.decodeIfPresent(String.self, forKey: .body) ?? ""
        super.init()
    }
    
    required init() {
        super.init()
    }
}
