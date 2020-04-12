//
//  PostViewModel.swift
//  ZMAppChallenge
//
//  Created by Cris on 9/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class PostViewModel {
    
    struct Constants {
        static let limitUnreadPost = 20
    }
    
    let postServices: PostManagmentService = PostManagmentService()
    let cacheManager: DataManagerCacheProvider?
    
    var posts = [Post]() {
        didSet {
            postCellViewModel = posts.compactMap { PostCellViewModel(postModel: $0) }
        }
    }
    var postCellViewModel = [PostCellViewModel]()
    private weak var delegate: ViewModelServiceDelegate?
    
    init(delegate: ViewModelServiceDelegate, cacheManager: DataManagerCacheProtocol = DataManagerCacheProvider()) {
        self.delegate = delegate
        self.cacheManager = cacheManager as? DataManagerCacheProvider
    }
    
    func fetchPost() {
        loadCachePosts()
        delegate?.willServiceStart()
        postServices.loadPost { [weak self] (posts, error) in
            DispatchQueue.main.async {
                if let apiError = error {
                    self?.delegate?.didServiceFail(with: apiError)
                } else {
                    self?.posts = posts.enumerated().compactMap { (index, model) -> Post in
                        model.imageType = index < Constants.limitUnreadPost ? .notRead : .none
                        return model
                    }
                    self?.cachePosts()
                    self?.delegate?.didServiceFinish()
                }
            }
        }
    }
    
    func updateUnreadPost(selected: PostCellViewModel) {
        if selected.postModel.imageType != .favorite {
            selected.postModel.imageType = .none
        }
    }
    
    func updateFavoritePost(selected: PostCellViewModel) {
        selected.postModel.imageType =  selected.postModel.imageType == .none ? .favorite : .none
    }
    
    func deleteAllPost() {
        deleteAllCachePosts()
    }
}

private extension PostViewModel {
    
    func cachePosts() {
        cacheManager?.saveObjects(objects: self.posts)
    }
    
    func loadCachePosts() {
        do {
            guard let cachePosts = try self.cacheManager?.fetch(classType: Post.self) else { return }
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
