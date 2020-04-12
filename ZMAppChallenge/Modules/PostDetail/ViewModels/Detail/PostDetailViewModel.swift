//
//  PostDetailViewModel.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit
class PostDetailViewModel {
    
    let userServices = UserManagmentService()
    let commentServices = CommentManagmentService()
    let cacheManager: DataManagerCacheProvider?
    
    private weak var delegate: ViewModelServiceDelegate?
    var user: User? {
        didSet {
            guard let userModel = user else {
                
                return
            }
            userInfo = UserViewModel(userModel: userModel)
        }
    }
    var userInfo: UserViewModel?
    
    var comments = [Comment]() {
        didSet {
            commentsViewModel = comments.compactMap { CommentCellViewModel(commetModel: $0) }
        }
    }
    var commentsViewModel = [CommentCellViewModel]()
    
    init(delegate: ViewModelServiceDelegate, cacheManager: DataManagerCacheProtocol = DataManagerCacheProvider()) {
        self.delegate = delegate
        self.cacheManager = cacheManager as? DataManagerCacheProvider
    }
    
    func fetchUser(postUserID: Int) {
        loadCacheUser(postUserID: postUserID)
        
        self.delegate?.willServiceStart()
        userServices.loadUser(with: postUserID) { [weak self] (user, error) in
            DispatchQueue.main.async {
                if let apiError = error {
                    self?.delegate?.didServiceFail(with: apiError)
                } else {
                    guard let userModel = user else {
                        self?.delegate?.didServiceFail(with: APIErrorType.generalServiceError)
                        return
                    }
                    
                    self?.user = userModel
                    self?.cacheUser()
                    self?.delegate?.didServiceFinish()
                }
            }
        }
    }
    
    func fetchComments(postID: Int) {
        loadCacheComments(postID: postID)
        commentServices.loadComments(with: postID) { [weak self] (comments, error) in
            DispatchQueue.main.async {
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
    
    func loadCacheCommentsIfServicesFail(postID: Int) {
        loadCacheComments(postID: postID)
    }
}

private extension PostDetailViewModel {
    
    func cacheUser() {
        self.cacheManager?.saveObject(object: self.user)
    }
    
    func loadCacheUser(postUserID: Int) {
        do {
            user = try self.cacheManager?.fetch(classType: User.self).first(where: { $0.userId == postUserID} )
        } catch {
            
        }
    }
    
    func cacheComments() {
        self.cacheManager?.saveObjects(objects: self.comments)
    }
    
    func loadCacheComments(postID: Int) {
        do {
            let fetchedComments = try self.cacheManager?.fetch(classType: Comment.self).filter { $0.postId ==  postID }
            guard let cacheComments = fetchedComments else { return }
            comments = cacheComments
        } catch {
            
        }
    }
}
