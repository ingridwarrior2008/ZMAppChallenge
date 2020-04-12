//
//  ZMPostDetailTableViewCell.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class ZMCommentTableViewCell: UITableViewCell, ZMTableViewCellProtocol {

    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func config(_ viewModel: ZMPostViewModel) {
        //postLabel?.text = viewModel.tile
    }

}
