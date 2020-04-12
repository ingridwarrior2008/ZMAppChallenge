//
//  CommentDataSource.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class CommentDataSource: NSObject, DataSourceProtocol {
    
    private(set) var tableView: UITableView
    private var viewModels = [CommentCellViewModel]() {
        didSet {
            reloadData()
        }
    }
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.tableView.dataSource = self
    }
    
    func reloadModel(viewModelItems: [CommentCellViewModel]) {
        removeAll()
        configure(viewModelItems: viewModelItems)
    }
    
    func removeAll() {
        viewModels.removeAll()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func configure(viewModelItems: [CommentCellViewModel]) {
        viewModels = viewModelItems
    }
}

extension CommentDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier, for: indexPath) as? DescriptionTableViewCell {
            let viewModel = viewModels[indexPath.row]
            cell.config(viewModel.body)
            tableCell = cell
        }
        
        return tableCell
    }
}

