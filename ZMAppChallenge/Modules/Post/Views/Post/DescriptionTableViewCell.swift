//
//  DescriptionTableViewCell.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell, TableViewCellProtocol {

    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postTypeView: PostView!

    func config(_ text: String, imageType: PostStatusType = .none) {
        postLabel?.text = text
        postTypeView?.config(type: imageType)
    }
}
