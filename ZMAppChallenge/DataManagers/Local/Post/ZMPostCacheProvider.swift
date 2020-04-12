//
//  ZMPostCacheProvider.swift
//  ZMAppChallenge
//
//  Created by Cris on 11/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation
import RealmSwift
import os.log

extension ZMDataManagerCacheProvider {
    
    func updatePostStatus(id: Int, postType: ZMPostStatusType) {
        let post = realm?.objects(ZMPost.self).first(where: { $0.postId == id })
        do {
            try realm?.write {
                post?.imageType = postType
            }
        } catch {
            os_log("Error when trying to update post", type: .error)
        }
    }
}
