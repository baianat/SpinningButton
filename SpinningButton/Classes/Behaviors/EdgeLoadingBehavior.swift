//
//  EdgeLoadingBehavior.swift
//  LoadingButton
//
//  Created by Omar on 9/25/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class EdgeLoadingBehavior: BaseBehavior {
    
    private var offset: CGFloat
    private var isTrailing = false
    
    private var titleWhileLoading: String?
    private var cachedTitle: String?
    
    private var animationCompleted = false
    init(
        button: SpinningButton,
        offset: CGFloat = 4.0,
        isTrailing: Bool,
        titleWhileLoading: String?
    ) {
        self.offset = offset
        self.isTrailing = isTrailing
        self.titleWhileLoading = titleWhileLoading
        super.init(button: button)
        setupConstraints()
    }
    
    override func startAnimating() {
        animationCompleted = false
        guard let button = button else {return}
        UIView.animate(
            withDuration: 0.3,
            delay: 0.05,
            usingSpringWithDamping: 0.45,
            initialSpringVelocity: 0,
            options: .curveEaseInOut,
            animations: {
            button.loadingSpinner.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { _ in
            button.loadingSpinner.startAnimating()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.animationCompleted = true
        }
        if let titleWhileLoading = titleWhileLoading {
            cachedTitle = button.title(for: .normal)
            button.setTitle(titleWhileLoading, for: .normal)
        }
    }
    
    private func setupConstraints() {
        guard let button = button else {return}
        button.addSubview(button.loadingSpinner)
        button.loadingSpinner.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        if isTrailing {
            button.loadingSpinner.trailingAnchor.constraint(
                equalTo: button.trailingAnchor,
                constant: -offset
            ).isActive = true
        } else {
            button.loadingSpinner.leadingAnchor.constraint(
                equalTo: button.leadingAnchor,
                constant: offset
            ).isActive = true
        }
    }
    
    override func stopAnimating() {
        guard let button = button else {return}
        
        let delay = animationCompleted ? 0 : 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            
            button.loadingSpinner.stopAnimating()
            
            if self.titleWhileLoading != nil {
                button.setTitle(self.cachedTitle, for: .normal)
            }
            button.isUserInteractionEnabled = true
        }
        
    }
    
}
