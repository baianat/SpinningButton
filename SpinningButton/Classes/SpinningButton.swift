//
//  SpinnerButton.swift
//
//  Created by Omar on 9/25/20.
//

import UIKit

@IBDesignable open class SpinningButton: UIButton {

    @IBInspectable public var loaderColor: UIColor = .white

    public var isAnimating = false

    lazy var loadingSpinner: UIActivityIndicatorView = {
        let loginSpinner = UIActivityIndicatorView()
        loginSpinner.color = loaderColor
        loginSpinner.translatesAutoresizingMaskIntoConstraints = false
        return loginSpinner
    }()

    private var loadingBehavior: BaseBehavior?

    public func startAnimating(at position: LoaderPosition) {
        isUserInteractionEnabled = false

        isAnimating = true
        loadingBehavior = BaseBehavior.create(for: position, onButton: self)
        loadingBehavior?.startAnimating()

    }

    public func stopAnimating() {
        isAnimating = false
        loadingBehavior?.stopAnimating()
        isUserInteractionEnabled = true
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadingSpinner.color = loaderColor

    }

}
