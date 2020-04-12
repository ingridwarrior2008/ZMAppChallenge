//
//  ZMDescriptionTableViewCell.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class ZMDescriptionTableViewCell: UITableViewCell, ZMTableViewCellProtocol {

    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postTypeView: ZMPostView!

    func config(_ text: String, imageType: ZMPostStatusType = .none) {
        postLabel?.text = text
        postTypeView?.config(type: imageType)
    }
}
