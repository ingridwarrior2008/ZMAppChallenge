//
//  ZMPostCellViewModel.swift
//  ZMAppChallenge
//
//  Created by Cris on 9/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

extension ZMPostStatusType {
    func getImageName() -> String {
        switch self {
        case .favorite:
            return "star.fill"
        case .notRead:
            return "circle.fill"
        default:
            return ""
        }
    }
    
    func getColor() -> UIColor {
        switch self {
        case .favorite:
            return UIColor.yellow
        case .notRead:
            return UIColor.blue
        default:
            return UIColor.white
        }
    }
    
    func getFavoriteButtonImageName() -> String {
        switch self {
        case .favorite:
            return "star.fill"
        default:
            return "star"
        }
    }
}

protocol ZMPostCellViewModelProtocol {
    var tile: String { get }
    var description: String { get }
    var postModel: ZMPost { get }
}

class ZMPostCellViewModel: ZMPostCellViewModelProtocol {
    
    var tile: String {
        return postModel.title
    }
    
    var description: String {
        return postModel.body
    }
    var postModel: ZMPost
    
    var imageCellName: String {
        return postModel.imageType.getImageName()
    }
    
    var imageCellColor: UIColor {
        return postModel.imageType.getColor()
    }
    
    var favoriteImageName: String {
        return postModel.imageType.getFavoriteButtonImageName()
    }
    
    init(postModel: ZMPost) {
        self.postModel = postModel
    }
}
