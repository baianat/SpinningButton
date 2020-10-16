//
//  ViewController.swift
//  SpinningButton
//
//  Created by development@baianat.com on 10/12/2020.
//  Copyright (c) 2020 development@baianat.com. All rights reserved.
//

import UIKit
import SpinningButton

class ViewController: UIViewController {

    @IBOutlet weak var centreShrinkyButton: SpinningButton!
    @IBOutlet weak var centreButton: SpinningButton!

    @IBOutlet weak var leadingLoaderWithTextButton: SpinningButton!
    @IBOutlet weak var leadingLoaderButton: SpinningButton!
    @IBOutlet weak var trailingLoaderWithTextButton: SpinningButton!
    @IBOutlet weak var trailingLoader: SpinningButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        [centreShrinkyButton, centreButton, leadingLoaderWithTextButton, leadingLoaderButton, trailingLoaderWithTextButton, trailingLoader].forEach({
            $0?.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            $0?.setTitleColor(.white, for: .normal)
            $0?.layer.cornerRadius = 16.0
            $0?.layer.masksToBounds = true
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func shrinky(_ sender: Any) {
        centreShrinkyButton.startAnimating(at: .centre(shrink: true))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.centreShrinkyButton.stopAnimating()
        }
    }
    @IBAction func centreAction(_ sender: Any) {
        centreButton.startAnimating(at: .centre(shrink: false))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.centreButton.stopAnimating()
        }
    }
    @IBAction func trailingAction(_ sender: Any) {
        trailingLoader.startAnimating(at: .trailing(offset: 15, titleWhileLoading: nil))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.trailingLoader.stopAnimating()
        }
    }
    @IBAction func trailingActionWithText(_ sender: Any) {
        trailingLoaderWithTextButton.startAnimating(at: .trailing(offset: 15, titleWhileLoading: "Loading"))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.trailingLoaderWithTextButton.stopAnimating()
        }
    }
    @IBAction func leadingAction(_ sender: Any) {
        leadingLoaderButton.startAnimating(at: .leading(offset: 15, titleWhileLoading: nil))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.leadingLoaderButton.stopAnimating()
        }
    }
    @IBAction func leadingActionWithText(_ sender: Any) {
        leadingLoaderWithTextButton.startAnimating(at: .leading(offset: 15, titleWhileLoading: "Loading"))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.leadingLoaderWithTextButton.stopAnimating()
        }
    }
}
