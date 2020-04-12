//
//  PostViewController.swift
//  ZMAppChallenge
//
//  Created by Cris on 9/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

protocol PostViewControllerDelegate: class {
    func didTapPost(postViewModel: PostCellViewModel)
    func didChangePostToFavorite(postViewModel: PostCellViewModel)
}

struct LoaderDeleteStyle: LottieLoaderProtocol {
    var animationFilename: String = "13605-deleted-successfully"
    var isLooping: Bool = false
}

class PostViewController: UIViewController {
    
    // MARK: - Constants
    
    private struct Constants {
        static let title = "post.title".localized()
        static let segue = "PostDescriptionSegue"
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    
    var dataSource: PostDataSource?
    var viewModel: PostViewModel?
    var loader: LottieLoaderViewController?
    var selectedPost: PostCellViewModel?
    var displayDeleteAnimation = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Private Extensions

private extension PostViewController {
    
    func setup() {
        title = Constants.title
        
        viewModel = PostViewModel(delegate: self)
        dataSource = PostDataSource(tableView: tableView, delegate: self)
        
        loader = LottieLoaderViewController(parentViewController: self)
        loader?.delegate = self
        updateSegmentUI()
        
        fetchPost()
    }
    
    func fetchPost() {
        viewModel?.fetchPost()
    }
    
    func updateSegmentUI() {
        guard let appColor = AppGlobalConstants.appNavMainColor else { return }
        
        filterSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: UIControl.State.selected)
        filterSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : appColor], for: UIControl.State.normal)
    }
    
    func updatePostImageType(postViewModel: PostCellViewModel) {
        dataSource?.reloadData()
    }
    
    func dismissLoader() {
        DispatchQueue.main.asyncAfter(deadline: .now() + AppGlobalConstants.delay) {
            self.loader?.dismiss()
        }
    }
}

// MARK: - IBActions

extension PostViewController {
    
    @IBAction func didTapReloadPostButton(_ sender: Any) {
        fetchPost()
    }
    
    @IBAction func didTapDeleteAllButton(_ sender: Any) {
        displayDeleteAnimation = true
        loader?.show(loaderStyle: LoaderDeleteStyle())
    }
    
    @IBAction func didSegmentedControlChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            dataSource?.filterAll()
        } else {
            dataSource?.filterFavorites()
        }
    }
}

// MARK: - PostViewControllerDelegate

extension PostViewController: PostViewControllerDelegate {
    
    func didTapPost(postViewModel: PostCellViewModel) {
        selectedPost = postViewModel
        performSegue(withIdentifier: Constants.segue, sender: self)
    }
    
    func didChangePostToFavorite(postViewModel: PostCellViewModel) {
        updatePostImageType(postViewModel: postViewModel)
    }
}

// MARK: - LottieLoaderDelegate

extension PostViewController: LottieLoaderDelegate {
    func didCompleteAnimation() {
        if displayDeleteAnimation {
            dataSource?.removeAll()
            viewModel?.deleteAllPost()
            displayDeleteAnimation = false
            loader?.dismiss()
        }
    }
}

// MARK: - ViewModelServiceDelegate

extension PostViewController: ViewModelServiceDelegate {
    
    func willServiceStart() {
        loader?.show()
    }
    
    func didServiceFinish() {
        dismissLoader()
        dataSource?.reloadModel(viewModelItems: viewModel?.postCellViewModel ?? [PostCellViewModel]())
    }
    
    func didServiceFail(with error: APIErrorType) {
        didServiceFinish()
        presentAlert(message: AppGlobalConstants.errorMessage)
    }
}

// MARK: - Navigation

extension PostViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segue {
            guard let postDetailViewController = segue.destination as? PostDetailViewController,
                let postCellViewModel = selectedPost,
                let postViewModel = viewModel else {
                    return
            }
            
            viewModel?.updateUnreadPost(selected: postCellViewModel)
            updatePostImageType(postViewModel: postCellViewModel)
            postDetailViewController.configure(postCellViewModel: postCellViewModel, postViewModel: postViewModel, delegate: self)
        }
    }
}
