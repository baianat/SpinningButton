//
//  CentreLoadingBehavior.swift
//
//  Created by Omar on 9/25/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class CentreLoadingBehavior: BaseBehavior {

    private var shouldShrinkOnLoading: Bool
    private var cachedTitle: String? = ""
    private var cachedCornerRadius: CGFloat = 0.0
    private var cachedImage: UIImage?

    init(button: SpinningButton, shrinkOnLoading: Bool = false) {
        self.shouldShrinkOnLoading = shrinkOnLoading
        super.init(button: button)
    }

    override func startAnimating() {
        guard let button = button else {return}

        setupConstraint()
        cacheState()
        button.clearTitleAndImage()
        animateSpinnerAndShrinkButton()
    }

    private func setupConstraint() {
        guard let button = button else { return }
        button.addSubview(button.loadingSpinner)
        button.loadingSpinner.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true

        if shouldShrinkOnLoading {
            let offset = (button.frame.height - 20) / 2
            button.loadingSpinner.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: offset).isActive = true
        } else {
            button.loadingSpinner.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        }
    }

    private func cacheState() {
        self.cachedTitle = button?.title(for: .normal)
        self.cachedImage = button?.image(for: .normal)
        self.cachedCornerRadius = button?.layer.cornerRadius ?? 0
    }

    private func animateSpinnerAndShrinkButton() {
        button?.loadingSpinner.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.45, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.button?.loadingSpinner.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { _ in
            self.button?.loadingSpinner.startAnimating()

            if self.shouldShrinkOnLoading {
                self.button?.animateShrinking()
            }
        }
    }

    override func stopAnimating() {
        if button?.loadingSpinner.isAnimating != true {
            return
        }
        button?.loadingSpinner.stopAnimating()
        if shouldShrinkOnLoading {
            button?.animateToOriginalWidth(completion: restoreCachedState)
        } else {
            restoreCachedState()
        }
    }

    private func restoreCachedState() {
        button?.setTitle(cachedTitle, for: .normal)
        button?.setImage(cachedImage, for: .normal)
        UIView.animate(withDuration: 0.15) {
            self.button?.layer.cornerRadius = self.cachedCornerRadius
        }

    }

}

private let shrinkCurve: CAMediaTimingFunction = CAMediaTimingFunction(name: .linear)
private let expandCurve: CAMediaTimingFunction = CAMediaTimingFunction(controlPoints: 0.95, 0.02, 1, 0.05)
private let shrinkDuration: CFTimeInterval = 0.25

private extension UIButton {

    func clearTitleAndImage() {
        setTitle(nil, for: .normal)
        setImage(nil, for: .normal)
    }

    func animateShrinking() {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.layer.cornerRadius = self.frame.height / 2
        }, completion: { _ -> Void in
            self.shrink()
        })
    }

    func shrink() {
        let shrinkAnimation = CABasicAnimation(keyPath: "bounds.size.width")
        shrinkAnimation.fromValue = frame.width
        shrinkAnimation.toValue = frame.height
        shrinkAnimation.duration = shrinkDuration
        shrinkAnimation.timingFunction = shrinkCurve
        shrinkAnimation.fillMode = .forwards
        shrinkAnimation.isRemovedOnCompletion = false
        layer.add(shrinkAnimation, forKey: shrinkAnimation.keyPath)

    }

    func animateToOriginalWidth(completion:(() -> Void)?) {
        let shrinkAnim = CABasicAnimation(keyPath: "bounds.size.width")
        shrinkAnim.fromValue = (self.bounds.height)
        shrinkAnim.toValue = (self.bounds.width)
        shrinkAnim.duration = shrinkDuration
        shrinkAnim.timingFunction = shrinkCurve
        shrinkAnim.fillMode = .forwards
        shrinkAnim.isRemovedOnCompletion = false

        CATransaction.setCompletionBlock {
//            self.setNeedsLayout()
//            self.setNeedsDisplay()
            completion?()
        }
        self.layer.add(shrinkAnim, forKey: shrinkAnim.keyPath)

        CATransaction.commit()
    }

}
