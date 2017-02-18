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

    public func equals(_ constant: CGFloat) -> NSLayoutConstraint {
        return createConstraint(withConstant: constant, relatedBy: .equal)
    }

    public func greaterThanOrEquals(_ constant: CGFloat) -> NSLayoutConstraint {
        return createConstraint(withConstant: constant, relatedBy: .greaterThanOrEqual)
    }

    public func lessThanOrEquals(_ constant: CGFloat) -> NSLayoutConstraint {
        return createConstraint(withConstant: constant, relatedBy: .lessThanOrEqual)
    }
}

public func == (lhs: LayoutPin, rhs: LayoutPin) -> NSLayoutConstraint {
    return lhs.equals(rhs)
}

public func <= (lhs: LayoutPin, rhs: LayoutPin) -> NSLayoutConstraint {
    return lhs.lessThanOrEquals(rhs)
}

public func >= (lhs: LayoutPin, rhs: LayoutPin) -> NSLayoutConstraint {
    return lhs.greaterThanOrEquals(rhs)
}

public func == (lhs: LayoutPin, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.equals(rhs)
}

public func <= (lhs: LayoutPin, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.lessThanOrEquals(rhs)
}

public func >= (lhs: LayoutPin, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.greaterThanOrEquals(rhs)
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

// MARK: Sequences

extension Collection where Iterator.Element == LayoutPin {

    internal func makeConstraints(_ otherPins: Self, relation: NSLayoutRelation) -> [NSLayoutConstraint] {
        guard self.count == otherPins.count else {
            fatalError("Left-hand side pin count does not match right-hand side pin count")
        }

        var result = [NSLayoutConstraint]()

        var index = startIndex

        while index < endIndex {

            let lhs = self[index]
            let rhs = otherPins[index]

            result.append(lhs.createConstraint(combining: rhs, relatedBy: relation))

            index = self.index(after: index)
        }

        return result
    }

    func equals(_ otherPins: Self) -> [NSLayoutConstraint] {
        return makeConstraints(otherPins, relation: .equal)
    }

    func lessThanOrEquals(_ otherPins: Self) -> [NSLayoutConstraint] {
        return makeConstraints(otherPins, relation: .lessThanOrEqual)
    }

    func greaterThanOrEquals(_ otherPins: Self) -> [NSLayoutConstraint] {
        return makeConstraints(otherPins, relation: .greaterThanOrEqual)
    }
}

public func == (lhs: [LayoutPin], rhs: [LayoutPin]) -> [NSLayoutConstraint] {
    return lhs.equals(rhs)
}

public func <= (lhs: [LayoutPin], rhs: [LayoutPin]) -> [NSLayoutConstraint] {
    return lhs.lessThanOrEquals(rhs)
}

public func >= (lhs: [LayoutPin], rhs: [LayoutPin]) -> [NSLayoutConstraint] {
    return lhs.greaterThanOrEquals(rhs)
}
