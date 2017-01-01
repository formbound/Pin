Layout
========
<a href="https://swift.org"><img src="https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat" alt="Swift" /></a>
<a href="https://tldrlegal.com/license/mit-license"><img src="https://img.shields.io/badge/License-MIT-blue.svg?style=flat" alt="License" /></a>

Layout gives you an easily readable, easily writable layout API for iOS, macOS and tvOS while maintaining as little overhead as possible.


## Usage

```swift
import UIKit
import Layout

class ViewController: UIViewController {

    let label = UIView()

    lazy var labelCenterYConstraint: NSLayoutConstraint = {
        return self.label.centerY == self.view.centerY
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        NSLayoutConstraint.activate([
            label.top == view.topMargin,
            label.centerX == view.centerX,
            label.left >= view.leftMargin,
            label.right <= view.rightMargin,
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewdidLoad(animated)
        
        labelCenterYConstraint.active = true
    }
}```
