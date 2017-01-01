#if os(OSX)
    import AppKit
    public typealias View = NSView
    public typealias LayoutPriority = NSLayoutPriority

    @available(OSX 10.11, *)
    public typealias LayoutGuide = NSLayoutGuide
#elseif os(iOS) || os(tvOS)
    import UIKit
    public typealias View = UIView
    public typealias LayoutPriority = UILayoutPriority

    @available(iOS 9.0, *)
    public typealias LayoutGuide = UILayoutGuide
#endif


public protocol Layoutable: AnyObject {}

extension Layoutable {
    public var left: LayoutItem<LayoutDirection.Horizontal> {
        return LayoutItem(item: self, attribute: .left)
    }

    public var leftMargin: LayoutItem<LayoutDirection.Horizontal> {
        return LayoutItem(item: self, attribute: .leftMargin)
    }

    public var right: LayoutItem<LayoutDirection.Horizontal> {
        return LayoutItem(item: self, attribute: .right)
    }

    public var rightMargin: LayoutItem<LayoutDirection.Horizontal> {
        return LayoutItem(item: self, attribute: .rightMargin)
    }

    public var top: LayoutItem<LayoutDirection.Vertical> {
        return LayoutItem(item: self, attribute: .top)
    }

    public var topMargin: LayoutItem<LayoutDirection.Vertical> {
        return LayoutItem(item: self, attribute: .topMargin)
    }

    public var bottom: LayoutItem<LayoutDirection.Vertical> {
        return LayoutItem(item: self, attribute: .bottom)
    }

    public var bottomMargin: LayoutItem<LayoutDirection.Vertical> {
        return LayoutItem(item: self, attribute: .bottomMargin)
    }

    public var leading: LayoutItem<LayoutDirection.Horizontal> {
        return LayoutItem(item: self, attribute: .leading)
    }

    public var leadingMargin: LayoutItem<LayoutDirection.Horizontal> {
        return LayoutItem(item: self, attribute: .leadingMargin)
    }

    public var trailing: LayoutItem<LayoutDirection.Horizontal> {
        return LayoutItem(item: self, attribute: .trailing)
    }

    public var trailingMargin: LayoutItem<LayoutDirection.Horizontal> {
        return LayoutItem(item: self, attribute: .trailingMargin)
    }

    public var width: LayoutItem<LayoutDirection.Size> {
        return LayoutItem(item: self, attribute: .width)
    }

    public var height: LayoutItem<LayoutDirection.Size> {
        return LayoutItem(item: self, attribute: .height)
    }

    public var centerX: LayoutItem<LayoutDirection.Horizontal> {
        return LayoutItem(item: self, attribute: .centerX)
    }

    public var centerY: LayoutItem<LayoutDirection.Vertical> {
        return LayoutItem(item: self, attribute: .centerY)
    }
}

@available(iOS 9.0, OSX 10.11, *)
extension LayoutGuide: Layoutable {}

extension View: Layoutable {}

public extension View {
    public var baseline: LayoutItem<LayoutDirection.Vertical> {
        return LayoutItem(item: self, attribute: .lastBaseline)
    }

    @available(iOS 8.0, OSX 10.11, *)
    public var firstBaseline: LayoutItem<LayoutDirection.Vertical> {
        return LayoutItem(item: self, attribute: .firstBaseline)
    }

    public var lastBaseline: LayoutItem<LayoutDirection.Vertical> {
        return LayoutItem(item: self, attribute: .lastBaseline)
    }
}
