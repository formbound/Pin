#if os(OSX)
    import AppKit
#elseif os(iOS) || os(tvOS)
    import UIKit
#endif


public struct LayoutItem {
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

    internal func createConstraint(combining other: LayoutItem, relatedBy relation: NSLayoutRelation) -> NSLayoutConstraint {
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

public func == (lhs: LayoutItem, rhs: LayoutItem) -> NSLayoutConstraint {
    return lhs.createConstraint(combining: rhs, relatedBy: .equal)
}

public func <= (lhs: LayoutItem, rhs: LayoutItem) -> NSLayoutConstraint {
    return lhs.createConstraint(combining: rhs, relatedBy: .lessThanOrEqual)
}

public func >= (lhs: LayoutItem, rhs: LayoutItem) -> NSLayoutConstraint {
    return lhs.createConstraint(combining: rhs, relatedBy: .greaterThanOrEqual)
}

public func == (lhs: LayoutItem, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.createConstraint(withConstant: rhs, relatedBy: .equal)
}

public func <= (lhs: LayoutItem, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.createConstraint(withConstant: rhs, relatedBy: .lessThanOrEqual)
}

public func >= (lhs: LayoutItem, rhs: CGFloat) -> NSLayoutConstraint {
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

public func + (lhs: LayoutItem, rhs: CGFloat) -> LayoutItem {
    var lhs = lhs
    lhs.constant += rhs
    return lhs
}

public func - (lhs: LayoutItem, rhs: CGFloat) -> LayoutItem {
    var lhs = lhs
    lhs.constant -= rhs
    return lhs
}

public func * (lhs: LayoutItem, rhs: CGFloat) -> LayoutItem {
    var lhs = lhs
    lhs.multiplier *= rhs
    return lhs
}

public func / (lhs: LayoutItem, rhs: CGFloat) -> LayoutItem {
    var lhs = lhs
    lhs.multiplier /= rhs
    return lhs
}
