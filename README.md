Layout
========
<a href="https://swift.org"><img src="https://img.shields.io/badge/Swift-3.0.2-orange.svg?style=flat" alt="Swift" /></a>
<a href="https://tldrlegal.com/license/mit-license"><img src="https://img.shields.io/badge/License-MIT-blue.svg?style=flat" alt="License" /></a>

Layout gives you an easily readable, easily writable layout API for iOS, macOS and tvOS while maintaining as little overhead as possible.


## Usage

```swift
import UIKit
import Layout

class ViewController: UIViewController {

    let label = UIView()

    lazy var labelCenterYConstraint: NSLayoutConstraint = {
        return self.label.layout.centerY == self.view.layout.centerY
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.layout.top == view.layout.topMargin,
            label.layout.centerX == view.layout.centerX,
            label.layout.left >= view.layout.leftMargin,
            label.layout.right <= view.layout.rightMargin,
            ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewdidLoad(animated)

        labelCenterYConstraint.isActive = true
    }
}
```

## Credits

- David Ask ([@davidask](https://github.com/davidask))

## License

Layout is released under the MIT license. See LICENSE for details.
