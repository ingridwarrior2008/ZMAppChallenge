//
//  ZMPostView.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class ZMPostView: UIView {
    
    // MARK: - Properties
    let imageView = UIImageView()
    
    var imageType: ZMPostStatusType = .none
    
    // MARK: - Constructor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func config(type: ZMPostStatusType) {
        imageType = type
        setup()
        fill()
    }

    func setup() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let centerY = imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        let centerX = imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        
        NSLayoutConstraint.activate([centerY, centerX])
    }
    
    func fill() {
        imageView.image = UIImage(systemName: imageType.getImageName())
        imageView.tintColor = imageType.getColor()
    }
}

