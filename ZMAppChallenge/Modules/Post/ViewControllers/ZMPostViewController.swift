//
//  ZMPostViewController.swift
//  ZMAppChallenge
//
//  Created by Cris on 9/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

protocol ZMPostViewControllerDelegate: class {
    func didTapPost(postViewModel: ZMPostCellViewModel)
    func didChangePostToFavorite(postViewModel: ZMPostCellViewModel)
}

struct ZMLoaderDeleteStyle: ZMLottieLoaderProtocol {
    var animationFilename: String = "13605-deleted-successfully"
    var isLooping: Bool = false
}

class ZMPostViewController: UIViewController {
    
    // MARK: - Constants
    
    private struct Constants {
        static let title = "post.title".localized()
        static let segue = "PostDescriptionSegue"
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    
    var dataSource: ZMPostDataSource?
    var viewModel: ZMPostViewModel?
    var loader: ZMLottieLoaderViewController?
    var selectedPost: ZMPostCellViewModel?
    var displayDeleteAnimation = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Private Extensions

private extension ZMPostViewController {
    
    func setup() {
        title = Constants.title
        
        viewModel = ZMPostViewModel(delegate: self)
        dataSource = ZMPostDataSource(tableView: tableView, delegate: self)
        
        loader = ZMLottieLoaderViewController(parentViewController: self)
        loader?.delegate = self
        updateSegmentUI()
        
        fetchPost()
    }
    
    func fetchPost() {
        viewModel?.fetchPost()
    }
    
    func updateSegmentUI() {
        guard let appColor = ZMAppGlobalConstants.appNavMainColor else { return }
        
        filterSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: UIControl.State.selected)
        filterSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : appColor], for: UIControl.State.normal)
    }
    
    func updatePostImageType(postViewModel: ZMPostCellViewModel) {
        dataSource?.reloadData()
    }
    
    func dismissLoader() {
        DispatchQueue.main.asyncAfter(deadline: .now() + ZMAppGlobalConstants.delay) {
            self.loader?.dismiss()
        }
    }
}

// MARK: - IBActions

extension ZMPostViewController {
    
    @IBAction func didTapReloadPostButton(_ sender: Any) {
        fetchPost()
    }
    
    @IBAction func didTapDeleteAllButton(_ sender: Any) {
        displayDeleteAnimation = true
        loader?.show(loaderStyle: ZMLoaderDeleteStyle())
    }
    
    @IBAction func didSegmentedControlChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            dataSource?.filterAll()
        } else {
            dataSource?.filterFavorites()
        }
    }
}

// MARK: - ZMPostViewControllerDelegate

extension ZMPostViewController: ZMPostViewControllerDelegate {
    
    func didTapPost(postViewModel: ZMPostCellViewModel) {
        selectedPost = postViewModel
        performSegue(withIdentifier: Constants.segue, sender: self)
    }
    
    func didChangePostToFavorite(postViewModel: ZMPostCellViewModel) {
        updatePostImageType(postViewModel: postViewModel)
    }
}

// MARK: - ZMLottieLoaderDelegate

extension ZMPostViewController: ZMLottieLoaderDelegate {
    func didCompleteAnimation() {
        if displayDeleteAnimation {
            dataSource?.removeAll()
            viewModel?.deleteAllPost()
            displayDeleteAnimation = false
            loader?.dismiss()
        }
    }
}

// MARK: - ZMViewModelServiceDelegate

extension ZMPostViewController: ZMViewModelServiceDelegate {
    func willServiceStart() {
        loader?.show()
    }
    
    func didServiceFinish() {
        dismissLoader()
        dataSource?.reloadModel(viewModelItems: viewModel?.postCellViewModel ?? [ZMPostCellViewModel]())
    }
    
    func didServiceFail(with error: ZMAPIErrorType) {
        didServiceFinish()
        presentAlert(message: ZMAppGlobalConstants.errorMessage)
    }
}

// MARK: - Navigation

extension ZMPostViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segue {
            guard let postDetailViewController = segue.destination as? ZMPostDetailViewController,
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
