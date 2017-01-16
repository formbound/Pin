Pin
========
<a href="https://swift.org"><img src="https://img.shields.io/badge/Swift-3.0.2-orange.svg?style=flat" alt="Swift" /></a>
<a href="https://tldrlegal.com/license/mit-license"><img src="https://img.shields.io/badge/License-MIT-blue.svg?style=flat" alt="License" /></a>

Pin gives you an easily readable, easily writable layout API for iOS, macOS and tvOS while maintaining as little overhead as possible.


## Usage

```swift
import UIKit
import Pin

class ViewController: UIViewController {

    let label = UIView()

    lazy var labelCenterYConstraint: NSLayoutConstraint = {
        return self.label.centerYPin == self.view.centerYPin
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.topPin == view.topMarginPin,
            label.centerXPin == view.centerXPin,
            label.leftPin >= view.leftMarginPin,
            label.rightPin <= view.rightMarginPin,
            ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

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

To integrate Pin into your Xcode project using Carthage, add the following to your `Cartfile`:

```
github "formbound/Pin"
```

## Credits

- David Ask ([@davidask](https://github.com/davidask))

## License

Pin is released under the MIT license. See LICENSE for details.
