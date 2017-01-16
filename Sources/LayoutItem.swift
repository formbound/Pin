#if os(OSX)
    import AppKit
#elseif os(iOS) || os(tvOS)
    import UIKit
#endif


public struct LayoutItem<T: LayoutDirectionProtocol> {
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

    internal func createConstraint(combining other: LayoutItem<T>, relatedBy relation: NSLayoutRelation) -> NSLayoutConstraint {
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

public func == <T: LayoutDirectionProtocol>(lhs: LayoutItem<T>, rhs: LayoutItem<T>) -> NSLayoutConstraint {
    return lhs.createConstraint(combining: rhs, relatedBy: .equal)
}

public func <= <T: LayoutDirectionProtocol>(lhs: LayoutItem<T>, rhs: LayoutItem<T>) -> NSLayoutConstraint {
    return lhs.createConstraint(combining: rhs, relatedBy: .lessThanOrEqual)
}

public func >= <T: LayoutDirectionProtocol>(lhs: LayoutItem<T>, rhs: LayoutItem<T>) -> NSLayoutConstraint {
    return lhs.createConstraint(combining: rhs, relatedBy: .greaterThanOrEqual)
}

public func == <T: LayoutDirectionProtocol>(lhs: LayoutItem<T>, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.createConstraint(withConstant: rhs, relatedBy: .equal)
}

public func <= <T: LayoutDirectionProtocol>(lhs: LayoutItem<T>, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.createConstraint(withConstant: rhs, relatedBy: .lessThanOrEqual)
}

public func >= <T: LayoutDirectionProtocol>(lhs: LayoutItem<T>, rhs: CGFloat) -> NSLayoutConstraint {
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

public func + <T: LayoutDirectionProtocol>(lhs: LayoutItem<T>, rhs: CGFloat) -> LayoutItem<T> {
    var lhs = lhs
    lhs.constant += rhs
    return lhs
}

public func - <T: LayoutDirectionProtocol>(lhs: LayoutItem<T>, rhs: CGFloat) -> LayoutItem<T> {
    var lhs = lhs
    lhs.constant -= rhs
    return lhs
}

public func * <T: LayoutDirectionProtocol>(lhs: LayoutItem<T>, rhs: CGFloat) -> LayoutItem<T> {
    var lhs = lhs
    lhs.multiplier *= rhs
    return lhs
}

public func / <T: LayoutDirectionProtocol>(lhs: LayoutItem<T>, rhs: CGFloat) -> LayoutItem<T> {
    var lhs = lhs
    lhs.multiplier /= rhs
    return lhs
}
