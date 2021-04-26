//
//  ViewController.swift
//  iWalkThrough
//
//  Created by iWalkThrough on 26/04/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func walkThroughAction(_ sender: UIButton) {
        WalkThroughViewController.show(config: WalkThroughConfig(xOffset: sender.center.x, yOffset: sender.center.y, radius: 100, title: "Sample Title", subTitle: "Sample subtitle"), on: self) {
            print("completed")
        }
    }
}

