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

### Constants, Multipliers and Priorities

```swift
let widthConstraint = label.widthPin <= view.widthPin * 0.75 ~ UILayoutPriorityDefaultHigh
let topConstraint = label.topPin == imageView.bottomPin + 10
```

### Convenience methods

Pin a views center. `offset` and `multiplier` is optional.

```swift
titleLabel.pinCenter(to: view) // [NSLayoutConstraint]
```

Pin a views edges to another view. `insets` is optional.

```swift
backgroundView.pinEdges(to: view) // [NSLayoutConstraint]
```
Pin a views edges to another views edge margins
```swift
longTextLabel.pinEdgeMargins(to: textContainer) // [NSLayoutConstraint]
```

`Sequence` of `NSLayoutConstraint` is extended when importing Pin with two methods.

```swift
let constraints = [
  label.centerXPin == view.centerXPin,
  label.width <= 250,
  label.topPin == view.topLayoutGuide.bottomPin
]

constraints.activate() // Activates constraints
constraints.deactivate() // Deactivates constraints
```

### Real-world usage

You can create multiple constraints without storing them, for instance, in `viewDidLoad`:

```swift
override func viewDidLoad() {
	super.viewDidLoad()
	
	var constraints = [NSLayoutConstraint]()

    constraints += backgroundView.pinEdges(to: view)

    constraints += [
      titleLabel.topPin == topLayoutGuide.bottomPin + 30,

      titleLabel.centerXPin == view.centerXPin,
      titleLabel.widthPin <= view.widthPin * 0.75,

      textContainer.bottomPin == bottomLayoutGuide.topPin - 30,
      textContainer.leftPin == view.leftMarginPin,
      textContainer.rightPin == view.rightMarginPin
    ]

    constraints += longTextLabel.pinEdgeMargins(to: textContainer)

    constraints.activate()
}
```



You can also use `NSLayoutConstraint.make` for an even cleaner implementation:

```swift
NSLayoutConstraint.make { constraints in
	constraints += backgroundView.pinEdges(to: view)
	constraints.append(textLabel.width == 200)
}.activate()
```



### Expressive syntax

If you don't fancy operators, you can use the more expressive syntax, or mix as you like:

```swift
NSLayoutConstraint.activate([
    label.topPin.equal(to: view.topMarginPin),
    label.centerXPin.equal(to: view.centerXPin),
    label.leftPin.greaterThanOrEqual(to: view.leftPin * 0.25) ~ UILayoutPriorityDefaultHigh,
    label.rightPin.lessThanOrEqual(to: view.rightPin.multiplied(by: 0.75).offset(by: 10)).prioritized(at: UILayoutPriorityDefaultHigh)
    ])
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
