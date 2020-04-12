//
//  ZMPostDetailViewController.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

enum ZMPostDetailFetchType {
    case user
    case comments
}

class ZMPostDetailViewController: UIViewController {
    
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
    
    weak var delegate: ZMPostViewControllerDelegate?
    var postCellViewModel: ZMPostCellViewModel?
    var postViewModel: ZMPostViewModel?
    var postDetailViewModel: ZMPostDetailViewModel?
    var dataSource: ZMCommentDataSource?
    var loader: ZMLottieLoaderViewController?
    var fetchType: ZMPostDetailFetchType = .user
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Public methods

extension ZMPostDetailViewController {
    
    func configure(postCellViewModel: ZMPostCellViewModel, postViewModel: ZMPostViewModel , delegate: ZMPostViewControllerDelegate?) {
        self.postCellViewModel = postCellViewModel
        self.postViewModel = postViewModel
        self.delegate = delegate
    }
}

// MARK: - IBActions
extension ZMPostDetailViewController {
    
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

private extension ZMPostDetailViewController {
    
    func setup() {
        title = Constants.title
        
        dataSource = ZMCommentDataSource(tableView: tableView)
        loader = ZMLottieLoaderViewController(parentViewController: self)
        
        postDetailViewModel = ZMPostDetailViewModel(delegate: self)
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
    
    func configUser(viewModel: ZMUserViewModel) {
        userNameLabel.text = viewModel.name
        userEmailLabel.text = viewModel.email
        userPhoneLabel.text = viewModel.phone
        userWebsiteLabel.attributedText = viewModel.website
    }
    
    func dismissLoader() {
        DispatchQueue.main.asyncAfter(deadline: .now() + ZMAppGlobalConstants.delay) {
            self.loader?.dismiss()
        }
    }
    
    func fetchUserInfo() {
        guard let userID = postCellViewModel?.postModel.userId else {
            return
        }
        
        postDetailViewModel?.fetchUser(postUserID: userID)
    }
    
    func reloadUserInfo() {
        guard let viewModel = postDetailViewModel?.userInfo else {
            return
        }
        fetchType = .comments
        DispatchQueue.main.async {
            self.configUser(viewModel: viewModel)
            self.displayUserInfoFadeInAnimation()
            self.fetchUserComments()
        }
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
}

// MARK: - ZMViewModelServiceDelegate

extension ZMPostDetailViewController: ZMViewModelServiceDelegate {
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
    
    func didServiceFail(with error: ZMAPIErrorType) {
        dismissLoader()
        presentAlert(message: ZMAppGlobalConstants.errorMessage)
    }
}
