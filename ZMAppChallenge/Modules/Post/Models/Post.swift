//
//  Post.swift
//  ZMAppChallenge
//
//  Created by Cris on 9/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit
import RealmSwift


enum PostStatusType {
    case favorite
    case notRead
    case none
}

@objcMembers class Post: Object, Codable {
    
    // MARK: - Properties
    dynamic var userId: Int = 0
    dynamic var postId: Int = 0
    dynamic var title: String = ""
    dynamic var body: String = ""
    
    dynamic var imageType: PostStatusType = .none
    
    enum CodingKeys: String, CodingKey {
        case postId = "id"
        case userId
        case title
        case body
    }
    
    required init(from decoder: Decoder) throws {
        let decode = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try decode.decodeIfPresent(Int.self, forKey: .userId) ?? 0
        self.postId = try decode.decodeIfPresent(Int.self, forKey: .postId) ?? 0
        self.title = try decode.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.body = try decode.decodeIfPresent(String.self, forKey: .body) ?? ""
        super.init()
    }
    
    required init() {
        super.init()
    }
}

