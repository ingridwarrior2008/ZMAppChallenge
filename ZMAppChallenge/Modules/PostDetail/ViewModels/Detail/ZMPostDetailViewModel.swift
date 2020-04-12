//
//  ZMPostDetailViewModel.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit
class ZMPostDetailViewModel {
    
    let userServices: ZMUserManagmentService?
    let commentServices: ZMCommentManagmentService?
    let cacheManager: ZMDataManagerCacheProvider?
    
    private weak var delegate: ZMViewModelServiceDelegate?
    var user: ZMUser? {
        didSet {
            guard let userModel = user else {
                
                return
            }
            userInfo = ZMUserViewModel(userModel: userModel)
        }
    }
    var userInfo: ZMUserViewModel?
    
    var comments = [ZMComment]() {
        didSet {
            commentsViewModel = comments.compactMap { ZMCommentCellViewModel(commetModel: $0) }
        }
    }
    var commentsViewModel = [ZMCommentCellViewModel]()
    
    init(delegate: ZMViewModelServiceDelegate,
         userServices: ZMNetworkManagmentService = ZMUserManagmentService(),
         commentServices: ZMNetworkManagmentService = ZMCommentManagmentService(),
         cacheManager: ZMDataManagerCacheProtocol = ZMDataManagerCacheProvider()) {
        self.delegate = delegate
        self.userServices = userServices as? ZMUserManagmentService
        self.commentServices = commentServices as? ZMCommentManagmentService
        self.cacheManager = cacheManager as? ZMDataManagerCacheProvider
    }
    
    func fetchUser(postUserID: Int) {
        loadCacheUser(postUserID: postUserID)
        
        self.delegate?.willServiceStart()
        userServices?.loadUser(with: postUserID) { [weak self] (user, error) in
            if let apiError = error {
                self?.delegate?.didServiceFail(with: apiError)
            }
            
            guard let userModel = user else {
                self?.delegate?.didServiceFinish()
                return
            }
            
            self?.user = userModel
            self?.cacheUser()
            self?.delegate?.didServiceFinish()
        }
    }
    
    func fetchComments(postID: Int) {
        commentServices?.loadComments(with: postID) { [weak self] (comments, error) in
            if let apiError = error {
                self?.delegate?.didServiceFail(with: apiError)
            } else {
                self?.comments = comments
                self?.cacheComments()
                self?.delegate?.didServiceFinish()
            }
        }
    }
}

private extension ZMPostDetailViewModel {
    
    func cacheUser() {
        DispatchQueue.main.async {
            self.cacheManager?.saveObject(object: self.user)
        }
    }
    
    func loadCacheUser(postUserID: Int) {
        do {
            user = try cacheManager?.fetch(classType: ZMUser.self).first(where: { $0.userId == postUserID} )
        } catch {
            
        }
    }
    
    func cacheComments() {
        DispatchQueue.main.async {
            self.cacheManager?.saveObjects(objects: self.comments)
        }
    }
    
    func loadCacheComments() {
        DispatchQueue.main.async {
            do {
                guard let cacheComments = try self.cacheManager?.fetch(classType: ZMComment.self) else { return }
                self.comments = cacheComments
            } catch {
                
            }
        }
    }
}
