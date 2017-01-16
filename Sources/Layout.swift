#if os(macOS)
    import AppKit
    public typealias View = NSView
    public typealias LayoutPriority = NSLayoutPriority
    
    @available(OSX 10.11, *)
    public typealias LayoutGuide = NSLayoutGuide
#elseif os(iOS) || os(tvOS)
    import UIKit
    public typealias View = UIView
    public typealias LayoutPriority = UILayoutPriority
    public typealias Insets = UIEdgeInsets
    
    @available(iOS 9.0, *)
    public typealias LayoutGuide = UILayoutGuide
#endif


public protocol Layoutable: AnyObject {}

extension Layoutable {
    
    public var leftConstraint: LayoutItem<LayoutDirection.Horizontal> {
        return LayoutItem(item: self, attribute: .left)
    }
    
    public var rightConstraint: LayoutItem<LayoutDirection.Horizontal> {
        return LayoutItem(item: self, attribute: .right)
    }
    
    public var topConstraint: LayoutItem<LayoutDirection.Vertical> {
        return LayoutItem(item: self, attribute: .top)
    }
    
    public var bottomConstraint: LayoutItem<LayoutDirection.Vertical> {
        return LayoutItem(item: self, attribute: .bottom)
    }
    
    public var leadingConstraint: LayoutItem<LayoutDirection.Horizontal> {
        return LayoutItem(item: self, attribute: .leading)
    }
    
    public var trailingConstraint: LayoutItem<LayoutDirection.Horizontal> {
        return LayoutItem(item: self, attribute: .trailing)
    }
    
    public var widthConstraint: LayoutItem<LayoutDirection.Size> {
        return LayoutItem(item: self, attribute: .width)
    }
    
    public var heightConstraint: LayoutItem<LayoutDirection.Size> {
        return LayoutItem(item: self, attribute: .height)
    }
    
    public var centerXConstraint: LayoutItem<LayoutDirection.Horizontal> {
        return LayoutItem(item: self, attribute: .centerX)
    }
    
    public var centerYConstraint: LayoutItem<LayoutDirection.Vertical> {
        return LayoutItem(item: self, attribute: .centerY)
    }
    
    #if os(macOS)
    
    public func edgeConstraints(equalTo other: Layoutable, insets: EdgeInsets = EdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) -> [NSLayoutConstraint] {
        return [
            leftConstraint == other.leftConstraint + insets.left,
            rightConstraint == other.rightConstraint - insets.left,
    
            topConstraint == other.topConstraint + insets.top,
            bottomConstraint == other.bottomConstraint - insets.bottom
        ]
    }
    
    #elseif os(iOS) || os(tvOS)
    
    public func edgeConstraints(equalTo other: Layoutable, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        return [
            leftConstraint == other.leftConstraint + insets.left,
            rightConstraint == other.rightConstraint - insets.left,
            
            topConstraint == other.topConstraint + insets.top,
            bottomConstraint == other.bottomConstraint - insets.bottom
        ]
    }
    
    #endif
}

#if os(iOS) || os(tvOS)
    public extension Layoutable {
        public var leftMarginConstraint: LayoutItem<LayoutDirection.Horizontal> {
            return LayoutItem(item: self, attribute: .leftMargin)
        }
        
        public var rightMarginConstraint: LayoutItem<LayoutDirection.Horizontal> {
            return LayoutItem(item: self, attribute: .rightMargin)
        }
        
        public var topMarginConstraint: LayoutItem<LayoutDirection.Vertical> {
            return LayoutItem(item: self, attribute: .topMargin)
        }
        
        public var bottomMarginConstraint: LayoutItem<LayoutDirection.Vertical> {
            return LayoutItem(item: self, attribute: .bottomMargin)
        }
        
        public var leadingMarginConstraint: LayoutItem<LayoutDirection.Horizontal> {
            return LayoutItem(item: self, attribute: .leadingMargin)
        }
        
        public var trailingMarginConstraint: LayoutItem<LayoutDirection.Horizontal> {
            return LayoutItem(item: self, attribute: .trailingMargin)
        }
    }
#endif


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

@available(OSX 10.10, iOS 8.0, tvOS 9.0, *)
public extension Sequence where Iterator.Element == NSLayoutConstraint {
    public func activate() {
        NSLayoutConstraint.activate(Array(self))
    }
    
    public func deactivate() {
        NSLayoutConstraint.activate(Array(self))
    }
}
