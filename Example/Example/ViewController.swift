//
//  ViewController.swift
//  Example
//
//  Created by David Ask on 2017-02-18.
//  Copyright © 2017 Formbound AB. All rights reserved.
//

import UIKit
import Pin

class ViewController: UIViewController {

    let backgroundView = UIImageView(image: UIImage(named: "Background"))

    let titleLabel = UILabel()

    let textContainer = UIView()

    let longTextLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create and configure the background view
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)

        // Create and configure the title label
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize * 2)
        titleLabel.text = "Welcome to the Pin iOS example!"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        // Create and configure the container view
        textContainer.layer.masksToBounds = true
        textContainer.layer.cornerRadius = 5
        textContainer.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        textContainer.layer.borderWidth = 1
        textContainer.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textContainer)

        // Create and configure the long text label
        longTextLabel.textColor = .white
        longTextLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla tristique magna sapien. Aliquam nec metus sed elit finibus ultricies. Sed in pulvinar est, sit amet placerat mi. Curabitur consectetur dolor vehicula, finibus sem in, consectetur velit. Vestibulum nulla massa, tempor eget nisl a, laoreet ultricies quam. Vivamus et massa arcu."
        longTextLabel.numberOfLines = 0
        longTextLabel.translatesAutoresizingMaskIntoConstraints = false
        textContainer.addSubview(longTextLabel)

        NSLayoutConstraint.make { constraints in
            constraints += backgroundView.constraints(pinningEdgesTo: view)

            constraints += [
                titleLabel.topPin.equal(to: topLayoutGuide.bottomPin + 30),

                titleLabel.centerXPin.equal(to: view.centerXPin),
                titleLabel.widthPin <= view.widthPin * 0.75,

                textContainer.bottomPin == bottomLayoutGuide.topPin - 30,
                textContainer.leftPin == view.leftMarginPin,
                textContainer.rightPin == view.rightMarginPin
            ]

            constraints += longTextLabel.constraints(pinningEdgeMarginsTo: textContainer)
        }.activate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
