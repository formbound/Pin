<img src="https://s14.postimg.org/3t6ko4ik1/pin_header.png" width="890" />


## Features

- [x] iOS 8 compatible
- [x] Maximum readability
- [x] No new concepts or magic


## Usage

`import Pin` adds new properties to `Layoutable` elements such as views and layout guides.

Define a constraint using operators like so:

```swift
let constraint = label.bottomPin == view.bottomPin // NSLayoutConstraint
```

two matching sequences of pins can create multiple constraints:

```swift
let constraints = label.centerPins == view.centerPins // [NSLayoutConstraints]
```

You can create multiple constraints without storing them, for instance, in `viewDidLoad`:

```swift
var constraints = [NSLayoutConstraint]()

constraints += backgroundView.edgePins == view.edgeMarginPins

constraints += [
  label.topPin == view.topLayoutGuide.bottomPin,
  label.centerXPin == view.centerXPin,
  label.widthPin <= view.widthPin * 0.75
]

constraints.activate()
```

### Constants, Multipliers and Priorities

```swift
let widthConstraint = label.widthPin <= view.widthPin * 0.75 ~ UILayoutPriorityDefaultHigh
let topConstraint = label.topPin == imageView.bottomPin + 10
```

### Expressive syntax

If you don't fancy operators, you can use the more expressive syntax, or mix as you like:

```swift
NSLayoutConstraint.activate([
    label.topPin.equals(view.topMarginPin),
    label.centerXPin.equals(view.centerXPin),
    label.leftPin.greaterThanOrEquals(view.leftPin * 0.25) ~ UILayoutPriorityDefaultHigh,
    label.rightPin.lessThanOrEquals(view.rightPin.multiplied(by: 0.75).offset(by: 10)).prioritized(at: UILayoutPriorityDefaultHigh)
])
```

Expressive syntax gives more options when it comes to setting up multiple constraints at once

```swift
let constraints = textLabel.constraintsForCenterPins(
	equalTo: view,
	offset: CGPoint(x: 10, y: 0),
	multiplier: 0.5
)
```

```swift
let constraints = textView.constraintsForEdgePins(
	equalTo: view,
	insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
)
```

## Setting up with Carthage

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

## About Formbound

[Formbound AB](https://github.com/formbound) is a software development firm devoted to open-source development.
