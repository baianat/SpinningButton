//
//  CentreLoadingBehavior.swift
//
//  Created by Omar on 9/25/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

public enum LoaderPosition: Equatable {
    case centre(shrink: Bool = true)
    case leading(offset: CGFloat = 4, titleWhileLoading: String? = nil)
    case trailing(offset: CGFloat = 4, titleWhileLoading: String? = nil)
}

class BaseBehavior {

    weak var button: SpinningButton?

    init(button: SpinningButton) {
        self.button = button
    }

    func startAnimating() {}
    func stopAnimating() {}

}

extension BaseBehavior {
    static func create(for position: LoaderPosition, onButton button: SpinningButton) -> BaseBehavior {
        switch position {
            case .centre(let shrink):
                return CentreLoadingBehavior(button: button, shrinkOnLoading: shrink)
            case .leading(let offset, let titleWhileLoading):
                return EdgeLoadingBehavior(button: button, offset: offset, isTrailing: false, titleWhileLoading: titleWhileLoading)
            case .trailing(let offset, let titleWhileLoading):
                return EdgeLoadingBehavior(button: button, offset: offset, isTrailing: true, titleWhileLoading: titleWhileLoading)
        }
    }
}
