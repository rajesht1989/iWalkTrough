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
        if sender.tag == 2 {
            let orgin = sender.convert(sender.bounds.origin, to: view)
            let center = CGPoint(x: orgin.x + sender.bounds.width / 2, y: orgin.y + sender.bounds.height / 2)
            WalkThroughViewController.show(config: WalkThroughConfig(xOffset: center.x, yOffset: center.y, radius: 100, title: "Sample Title", subTitle: "Walkthrough from inner view"), on: self) {
                print("completed")
            }

        } else if sender.tag == 1 {
            WalkThroughViewController.show(configurations: [WalkThroughConfig(xOffset: sender.center.x, yOffset: sender.center.y, radius: 60, title: "Sample Title", subTitle: "Stack message 1"), WalkThroughConfig(xOffset: sender.frame.origin.x, yOffset: sender.frame.origin.y, radius: 120, title: "Sample Title", subTitle: "Stack message 2"), WalkThroughConfig(xOffset: sender.center.x, yOffset: sender.center.y, radius: 80, title: "Sample Title", subTitle: "Stack message 3")], on: self) {
                print("completed")
            }
        } else {
            WalkThroughViewController.show(config: WalkThroughConfig(xOffset: sender.center.x, yOffset: sender.center.y, radius: 100, title: "Sample Title", subTitle: "Sample subtitle"), on: self) {
                print("completed")
            }
        }
    }
}

