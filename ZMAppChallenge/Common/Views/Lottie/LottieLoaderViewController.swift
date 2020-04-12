//
//  LottieLoaderViewController.swift
//  ZMAppChallenge
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit
import Lottie

protocol LottieLoaderProtocol {
    var animationFilename: String { get set }
    var isLooping: Bool { get set }
}

protocol LottieLoaderDelegate: class {
    func didCompleteAnimation()
}

struct LoaderDefaultStyle: LottieLoaderProtocol {
    var animationFilename: String = "18104-loading"
    var isLooping: Bool = true
}

class LottieLoaderViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var loaderAnimation: AnimationView!
    weak var delegate: LottieLoaderDelegate?
    
    
    let parentVC: UIViewController
    
    // MARK: Constructor
    
    init(parentViewController: UIViewController) {
        self.parentVC = parentViewController
        super.init(nibName: String(describing: LottieLoaderViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func show(loaderStyle: LottieLoaderProtocol = LoaderDefaultStyle(), frame: CGRect? = nil) {
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        guard let mainWindow = keyWindow else {
            return
        }
        
        if let viewFrame = frame {
            view.frame = viewFrame
        } else {
            view.frame = mainWindow.frame
        }
        
        mainWindow.addSubview(view)
        setupView(loaderStyle: loaderStyle)
    }
    
    func dismiss() {
        DispatchQueue.main.async {
            self.view.removeFromSuperview()
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: Private methods

private extension LottieLoaderViewController {
    
    func setupView(loaderStyle: LottieLoaderProtocol) {
        loaderAnimation.animation = Animation.named(loaderStyle.animationFilename)
        loaderAnimation.loopMode = loaderStyle .isLooping ? LottieLoopMode.loop : LottieLoopMode.playOnce
        loaderAnimation.play { [weak self] (complete) in
            self?.delegate?.didCompleteAnimation()
        }
    }
}

