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

    init(button: SpinningButton, offset: CGFloat = 4.0, isTrailing: Bool, titleWhileLoading: String? ) {
        self.offset = offset
        self.isTrailing = isTrailing
        self.titleWhileLoading = titleWhileLoading
        super.init(button: button)
        setupConstraints()
    }

    override func startAnimating() {
        guard let button = button else {return}
        UIView.animate(withDuration: 0.3, delay: 0.05, usingSpringWithDamping: 0.45, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            button.loadingSpinner.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { _ in
            button.loadingSpinner.startAnimating()
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
            button.loadingSpinner.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -offset).isActive = true
        } else {
            button.loadingSpinner.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: offset).isActive = true
        }
    }

    override func stopAnimating() {
        guard let button = button else {return}
        button.loadingSpinner.stopAnimating()

        if titleWhileLoading != nil {
            button.setTitle(cachedTitle, for: .normal)
        }

    }

}
