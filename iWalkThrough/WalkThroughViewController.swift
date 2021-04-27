//
//  WalkThroughViewController.swift
//  iWalkThrough
//
//  Created by iWalkThrough on 26/04/21.
//

import UIKit

struct WalkThroughConfig {
    let xOffset: CGFloat
    let yOffset: CGFloat
    let radius: CGFloat
    let title: String
    let subTitle: String
    
    func titleTopConstantFor(frame: CGRect) -> CGFloat {
        if frame.size.height - (yOffset + radius) > 200 {
         return yOffset + radius + 20
        } else {
            return yOffset - (radius + 100)
        }
    }
}

class WalkThroughViewController: UIViewController {
    var config: WalkThroughConfig!
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    var completion: (() -> Void)?

    static func show(config: WalkThroughConfig, on: UIViewController, completion: (() -> Void)? = nil) {
        let controller = WalkThroughViewController()
        controller.config = config
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        controller.completion = completion
        on.present(controller, animated: true)
    }
    
    static func show(configurations: [WalkThroughConfig], on: UIViewController, completion: (() -> Void)? = nil, index: Int = 0) {
        if configurations.count > index {
            let config = configurations[index]
            show(config: config, on: on) {
                show(configurations: configurations, on: on, completion: completion, index: index + 1)
            }
        } else {
            completion?()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        dismiss(animated: true)
    }
    
    func configureView() {
        view.addSubview(createOverlay())
        titleLabel.text = config.title
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: config.titleTopConstantFor(frame: view.bounds)).isActive = true

        subTitleLabel.text = config.subTitle
        subTitleLabel.font = .systemFont(ofSize: 30)
        subTitleLabel.textColor = .white
        subTitleLabel.numberOfLines = 2
        view.addSubview(subTitleLabel)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0).isActive = true
        subTitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 0).isActive = true
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapAction)))
    }
    
    @objc func viewTapAction()  {
        dismiss(animated: true, completion: completion)
    }
    
    func createOverlay() -> UIView {
        let overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: config.xOffset, y: config.yOffset), radius: config.radius, startAngle: 0.0, endAngle: 2.0 * .pi, clockwise: false)
        path.addRect(CGRect(origin: .zero, size: overlayView.frame.size))
        
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        maskLayer.fillRule = .evenOdd
        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true
        return overlayView
    }
    
}
