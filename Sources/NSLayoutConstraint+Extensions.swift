#if os(OSX)
    import AppKit
#elseif os(iOS) || os(tvOS)
    import UIKit
#endif

extension NSLayoutConstraint {
    public func prioritized(at priority: LayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }

    public static func make(handler: (inout [NSLayoutConstraint]) -> Void) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        handler(&constraints)
        return constraints
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
