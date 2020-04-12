//
//  ZMPostDataSource.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class ZMPostDataSource: NSObject, ZMDataSourceProtocol {
    
    //MARK: - Properties
    
    private(set) weak var delegate: ZMPostViewControllerDelegate?
    private(set) var tableView: UITableView
    private var viewModelsFilterAll = [ZMPostCellViewModel]()
    
    private var postCellViewModels = [ZMPostCellViewModel]() {
        didSet {
            reloadData()
        }
    }

    init(tableView: UITableView, delegate: ZMPostViewControllerDelegate?) {
        self.tableView = tableView
        self.delegate = delegate
        
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func reloadModel(viewModelItems: [ZMPostCellViewModel]) {
        removeAll()
        configure(viewModelItems: viewModelItems)
    }
    
    func removeAll() {
        postCellViewModels.removeAll()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func filterFavorites() {
        viewModelsFilterAll = postCellViewModels
        reloadModel(viewModelItems: postCellViewModels.filter({ $0.postModel.imageType == .favorite }))
    }
    
    func filterAll() {
        reloadModel(viewModelItems: viewModelsFilterAll)
    }
    
    private func configure(viewModelItems: [ZMPostCellViewModel]) {
        postCellViewModels = viewModelItems
    }
}

extension ZMPostDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: ZMDescriptionTableViewCell.identifier, for: indexPath) as? ZMDescriptionTableViewCell {
            let viewModel = postCellViewModels[indexPath.row]
            cell.config(viewModel.tile, imageType: viewModel.postModel.imageType)
            tableCell = cell
        }
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            postCellViewModels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}

extension ZMPostDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = postCellViewModels[indexPath.row]
        delegate?.didTapPost(postViewModel: viewModel)
    }
}
