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
        return self.label.centerYConstraint == self.view.centerYConstraint
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.topConstraint == view.topMarginConstraint,
            label.centerXConstraint == view.centerXConstraint,
            label.leftConstraint >= view.leftMarginConstraint,
            label.rightConstraint <= view.rightMarginConstraint,
            ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewdidLoad(animated)

        labelCenterYConstraint.isActive = true
    }
}
```

### Setting up with Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Layout into your Xcode project using Carthage, add the following to your `Cartfile`:

```
github "formbound/Layout"
```

## Credits

- David Ask ([@davidask](https://github.com/davidask))

## License

Layout is released under the MIT license. See LICENSE for details.
