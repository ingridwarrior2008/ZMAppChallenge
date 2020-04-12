//
//  ZMPostViewModel.swift
//  ZMAppChallenge
//
//  Created by Cris on 9/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class ZMPostViewModel {
    
    struct Constants {
        static let limitUnreadPost = 20
    }
    
    let postServices: ZMPostManagmentService?
    let cacheManager: ZMDataManagerCacheProvider?
    
    var posts = [ZMPost]() {
        didSet {
            postCellViewModel = posts.compactMap { ZMPostCellViewModel(postModel: $0) }
        }
    }
    var postCellViewModel = [ZMPostCellViewModel]()
    private weak var delegate: ZMViewModelServiceDelegate?
    
    init(delegate: ZMViewModelServiceDelegate,
         networkManagmentService: ZMNetworkManagmentService = ZMPostManagmentService(),
         cacheManager: ZMDataManagerCacheProtocol = ZMDataManagerCacheProvider()) {
        self.delegate = delegate
        self.postServices = networkManagmentService as? ZMPostManagmentService
        self.cacheManager = cacheManager as? ZMDataManagerCacheProvider
    }
    
    func fetchPost() {
        loadCachePosts()
        delegate?.willServiceStart()
        postServices?.loadPost { [weak self] (posts, error) in
            
            if let apiError = error {
                self?.delegate?.didServiceFail(with: apiError)
            } else {
                self?.posts = posts.enumerated().compactMap { (index, model) -> ZMPost in
                    model.imageType = index < Constants.limitUnreadPost ? .notRead : .none
                    return model
                }
                self?.cachePosts()
                self?.delegate?.didServiceFinish()
            }
        }
    }
    
    func updateUnreadPost(selected: ZMPostCellViewModel) {
        if selected.postModel.imageType != .favorite {
            selected.postModel.imageType = .none
        }
    }
    
    func updateFavoritePost(selected: ZMPostCellViewModel) {
        selected.postModel.imageType =  selected.postModel.imageType == .none ? .favorite : .none
    }
    
    func deleteAllPost() {
        deleteAllCachePosts()
    }
}

private extension ZMPostViewModel {
    
    func cachePosts() {
        DispatchQueue.main.async {
            self.cacheManager?.saveObjects(objects: self.posts)
        }
    }
    
    func loadCachePosts() {
        do {
            guard let cachePosts = try self.cacheManager?.fetch(classType: ZMPost.self) else { return }
            posts = cachePosts
        } catch {
            
        }
    }
    
    func deleteAllCachePosts() {
        DispatchQueue.main.async {
            self.cacheManager?.deleteAll()
        }
    }
}
