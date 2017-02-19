#if os(OSX)
    import AppKit
#elseif os(iOS) || os(tvOS)
    import UIKit
#endif

public struct LayoutPin {
    public let item: AnyObject
    public let attribute: NSLayoutAttribute
    public var multiplier: CGFloat
    public var constant: CGFloat

    public init(item: AnyObject, attribute: NSLayoutAttribute, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        self.item = item
        self.attribute = attribute
        self.multiplier = multiplier
        self.constant = constant
    }

    public func multiplied(by multiplier: CGFloat) -> LayoutPin {
        var new = self
        new.multiplier *= multiplier
        return new
    }

    public func offset(by constant: CGFloat) -> LayoutPin {
        var new = self
        new.constant += constant
        return new
    }

    @available(*, deprecated: 1.2.0, renamed: "equal(to:)")
    public func equals(_ other: LayoutPin) -> NSLayoutConstraint {
        return equal(to: other)
    }

    public func equal(to other: LayoutPin) -> NSLayoutConstraint {
        return createConstraint(combining: other, relatedBy: .equal)
    }

    @available(*, deprecated: 1.2.0, renamed: "greaterThanOrEqual(to:)")
    public func greaterThanOrEquals(_ other: LayoutPin) -> NSLayoutConstraint {
        return greaterThanOrEqual(to: other)
    }

    public func greaterThanOrEqual(to other: LayoutPin) -> NSLayoutConstraint {
        return createConstraint(combining: other, relatedBy: .greaterThanOrEqual)
    }

    @available(*, deprecated: 1.2.0, renamed: "lessThanOrEqual(to:)")
    public func lessThanOrEquals(_ other: LayoutPin) -> NSLayoutConstraint {
        return lessThanOrEqual(to: other)
    }

    public func lessThanOrEqual(to other: LayoutPin) -> NSLayoutConstraint {
        return createConstraint(combining: other, relatedBy: .lessThanOrEqual)
    }

    @available(*, deprecated: 1.2.0, renamed: "equal(to:)")
    public func equals(_ constant: CGFloat) -> NSLayoutConstraint {
        return equal(to: constant)
    }

    public func equal(to constant: CGFloat) -> NSLayoutConstraint {
        return createConstraint(withConstant: constant, relatedBy: .equal)
    }

    @available(*, deprecated: 1.2.0, renamed: "greaterThanOrEqual(to:)")
    public func greaterThanOrEquals(_ constant: CGFloat) -> NSLayoutConstraint {
        return greaterThanOrEqual(to: constant)
    }

    public func greaterThanOrEqual(to constant: CGFloat) -> NSLayoutConstraint {
        return createConstraint(withConstant: constant, relatedBy: .greaterThanOrEqual)
    }

    @available(*, deprecated: 1.2.0, renamed: "lessThanOrEqual(to:)")
    public func lessThanOrEquals(_ constant: CGFloat) -> NSLayoutConstraint {
        return lessThanOrEqual(to: constant)
    }

    public func lessThanOrEqual(to constant: CGFloat) -> NSLayoutConstraint {
        return createConstraint(withConstant: constant, relatedBy: .lessThanOrEqual)
    }
}

internal extension LayoutPin {
    internal func createConstraint(combining other: LayoutPin, relatedBy relation: NSLayoutRelation) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: self.item,
            attribute: attribute,
            relatedBy: relation,
            toItem: other.item,
            attribute: other.attribute,
            multiplier: other.multiplier,
            constant: other.constant
        )
    }

    internal func createConstraint(withConstant constant: CGFloat, relatedBy relation: NSLayoutRelation) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: self.item,
            attribute: attribute,
            relatedBy: relation,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: constant
        )
    }
}

public func == (lhs: LayoutPin, rhs: LayoutPin) -> NSLayoutConstraint {
    return lhs.equal(to: rhs)
}

public func <= (lhs: LayoutPin, rhs: LayoutPin) -> NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs)
}

public func >= (lhs: LayoutPin, rhs: LayoutPin) -> NSLayoutConstraint {
    return lhs.greaterThanOrEqual(to: rhs)
}

public func == (lhs: LayoutPin, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.equal(to: rhs)
}

public func <= (lhs: LayoutPin, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs)
}

public func >= (lhs: LayoutPin, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.greaterThanOrEqual(to: rhs)
}

public func + (lhs: LayoutPin, rhs: CGFloat) -> LayoutPin {
    var lhs = lhs
    lhs.constant += rhs
    return lhs
}

public func - (lhs: LayoutPin, rhs: CGFloat) -> LayoutPin {
    var lhs = lhs
    lhs.constant -= rhs
    return lhs
}

public func * (lhs: LayoutPin, rhs: CGFloat) -> LayoutPin {
    var lhs = lhs
    lhs.multiplier *= rhs
    return lhs
}

public func / (lhs: LayoutPin, rhs: CGFloat) -> LayoutPin {
    var lhs = lhs
    lhs.multiplier /= rhs
    return lhs
}
