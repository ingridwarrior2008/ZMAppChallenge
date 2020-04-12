//
//  PostDetailViewController.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

enum PostDetailFetchType {
    case user
    case comments
}

class PostDetailViewController: UIViewController {
    
    // MARK: - Constants
    private struct Constants {
        static let title = "post.title".localized()
        static let segue = "PostDescriptionSegue"
        static let fadeInDuration = 0.5
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var userWebsiteLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    //IBoutlet Collection
    @IBOutlet var alphaLabels: [UILabel] = [UILabel]()
    
    weak var delegate: PostViewControllerDelegate?
    var postCellViewModel: PostCellViewModel?
    var postViewModel: PostViewModel?
    var postDetailViewModel: PostDetailViewModel?
    var dataSource: CommentDataSource?
    var loader: LottieLoaderViewController?
    var fetchType: PostDetailFetchType = .user
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Public methods

extension PostDetailViewController {
    
    func configure(postCellViewModel: PostCellViewModel, postViewModel: PostViewModel , delegate: PostViewControllerDelegate?) {
        self.postCellViewModel = postCellViewModel
        self.postViewModel = postViewModel
        self.delegate = delegate
    }
}

// MARK: - IBActions
extension PostDetailViewController {
    
    @IBAction func didTapFavorite(_ sender: Any) {
        guard let cellViewModel = postCellViewModel, let postViewModel = postViewModel else {
            return
        }
        postViewModel.updateFavoritePost(selected: cellViewModel)
        updateFavoriteButton()
        delegate?.didChangePostToFavorite(postViewModel: cellViewModel)
    }
}

// MARK: - Private Extensions

private extension PostDetailViewController {
    
    func setup() {
        title = Constants.title
        
        dataSource = CommentDataSource(tableView: tableView)
        loader = LottieLoaderViewController(parentViewController: self)
        
        postDetailViewModel = PostDetailViewModel(delegate: self)
        postDescriptionLabel.text = postCellViewModel?.description
        updateFavoriteButton()
        alphaLabels.forEach { $0.alpha = 0 }
        
        fetchUserInfo()
    }
    
    func updateFavoriteButton() {
        guard let postVieModel = postCellViewModel else {
            return
        }
        
        favoriteButton.image = UIImage(systemName: postVieModel.favoriteImageName)
    }
    
    func configUser(viewModel: UserViewModel) {
        userNameLabel.text = viewModel.name
        userEmailLabel.text = viewModel.email
        userPhoneLabel.text = viewModel.phone
        userWebsiteLabel.attributedText = viewModel.website
    }
    
    func dismissLoader() {
        DispatchQueue.main.asyncAfter(deadline: .now() + AppGlobalConstants.delay) {
            self.loader?.dismiss()
        }
    }
    
    func fetchUserInfo() {
        guard let userID = postCellViewModel?.postModel.userId else {
            return
        }
        
        postDetailViewModel?.fetchUser(postUserID: userID)
    }
    
    func fillUserInfo() {
        guard let viewModel = postDetailViewModel?.userInfo else {
            return
        }
        
        configUser(viewModel: viewModel)
    }
    
    func reloadUserInfo() {
        fillUserInfo()
        fetchType = .comments
        
        fetchUserComments()
        displayUserInfoFadeInAnimation()
    }
    
    func reloadComments() {
        guard let viewModel = postDetailViewModel?.commentsViewModel else {
            return
        }
        dataSource?.reloadModel(viewModelItems: viewModel)
        fetchType = .user
    }
    
    func displayUserInfoFadeInAnimation() {
        UIView.animate(withDuration: Constants.fadeInDuration) {
            self.alphaLabels.forEach { $0.alpha = 1 }
        }
    }
    
    func fetchUserComments() {
        guard let postID = postCellViewModel?.postModel.postId else {
            return
        }
        postDetailViewModel?.fetchComments(postID: postID)
    }
    
    func fetchCacheComments() {
        guard let postID = postCellViewModel?.postModel.postId else {
            return
        }
        postDetailViewModel?.loadCacheCommentsIfServicesFail(postID: postID)
    }
}

// MARK: - ViewModelServiceDelegate

extension PostDetailViewController: ViewModelServiceDelegate {
    func willServiceStart() {
        loader?.show()
    }
    
    func didServiceFinish() {
        if fetchType == .user {
            reloadUserInfo()
        } else {
            reloadComments()
            dismissLoader()
        }
    }
    
    func didServiceFail(with error: APIErrorType) {
        dismissLoader()
        
        fillUserInfo()
        displayUserInfoFadeInAnimation()
        
        fetchCacheComments()
        reloadComments()
        presentAlert(message: AppGlobalConstants.errorMessage)
    }
}
