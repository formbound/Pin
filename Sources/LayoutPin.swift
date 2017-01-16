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

    init(item: AnyObject, attribute: NSLayoutAttribute, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        self.item = item
        self.attribute = attribute
        self.multiplier = multiplier
        self.constant = constant
    }

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
    
    public func equals(_ other: LayoutPin) -> NSLayoutConstraint {
        return createConstraint(combining: other, relatedBy: .equal)
    }
    
    public func greaterThanOrEquals(_ other: LayoutPin) -> NSLayoutConstraint {
        return createConstraint(combining: other, relatedBy: .greaterThanOrEqual)
    }
    
    public func lessThanOrEquals(_ other: LayoutPin) -> NSLayoutConstraint {
        return createConstraint(combining: other, relatedBy: .lessThanOrEqual)
    }
}

public func == (lhs: LayoutPin, rhs: LayoutPin) -> NSLayoutConstraint {
    return lhs.createConstraint(combining: rhs, relatedBy: .equal)
}

public func <= (lhs: LayoutPin, rhs: LayoutPin) -> NSLayoutConstraint {
    return lhs.createConstraint(combining: rhs, relatedBy: .lessThanOrEqual)
}

public func >= (lhs: LayoutPin, rhs: LayoutPin) -> NSLayoutConstraint {
    return lhs.createConstraint(combining: rhs, relatedBy: .greaterThanOrEqual)
}

public func == (lhs: LayoutPin, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.createConstraint(withConstant: rhs, relatedBy: .equal)
}

public func <= (lhs: LayoutPin, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.createConstraint(withConstant: rhs, relatedBy: .lessThanOrEqual)
}

public func >= (lhs: LayoutPin, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.createConstraint(withConstant: rhs, relatedBy: .greaterThanOrEqual)
}

precedencegroup ConstraintPriorityPrecedence {
    associativity: right
    lowerThan: ComparisonPrecedence
}

infix operator ~ : ConstraintPriorityPrecedence

public func ~ (lhs: NSLayoutConstraint, rhs: LayoutPriority) -> NSLayoutConstraint {
    lhs.priority = rhs
    return lhs
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
