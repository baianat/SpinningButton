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

    @IBOutlet weak var actionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionButton.backgroundColor = .blue
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.layer.cornerRadius = 16.0
        actionButton.layer.masksToBounds = true
        actionButton.setTitle("Show Loader", for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func action(_ sender: Any) {
        print("Worked")
    }
}

