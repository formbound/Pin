#if os(OSX)
    import AppKit
#elseif os(iOS) || os(tvOS)
    import UIKit
#endif

extension NSLayoutConstraint {
    func prioritized(at priority: LayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}

@available(OSX 10.10, iOS 8.0, tvOS 9.0, *)
public extension Sequence where Iterator.Element == NSLayoutConstraint {
    public func activate() {
        NSLayoutConstraint.activate(Array(self))
    }

    public func deactivate() {
        NSLayoutConstraint.deactivate(Array(self))
    }

    public func prioritized(at priority: LayoutPriority) -> [NSLayoutConstraint] {
        return map { constraint in
            constraint.priority = priority
            return constraint
        }
    }
}

precedencegroup ConstraintPriorityPrecedence {
    associativity: right
    lowerThan: ComparisonPrecedence
}

infix operator ~ : ConstraintPriorityPrecedence

public func ~ (lhs: NSLayoutConstraint, rhs: LayoutPriority) -> NSLayoutConstraint {
    return lhs.prioritized(at: rhs)
}

public func ~ <T: Sequence>(lhs: T, rhs: LayoutPriority) -> [NSLayoutConstraint] where T.Iterator.Element == NSLayoutConstraint {
    return lhs.prioritized(at: rhs)
}
