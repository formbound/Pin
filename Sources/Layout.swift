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

public struct Layout {
    
    public let layoutable: Layoutable
    
    public var left: LayoutItem<LayoutDirection.Horizontal> {
        return LayoutItem(item: layoutable, attribute: .left)
    }
    
    public var right: LayoutItem<LayoutDirection.Horizontal> {
        return LayoutItem(item: layoutable, attribute: .right)
    }
    
    public var top: LayoutItem<LayoutDirection.Vertical> {
        return LayoutItem(item: layoutable, attribute: .top)
    }
    
    public var bottom: LayoutItem<LayoutDirection.Vertical> {
        return LayoutItem(item: layoutable, attribute: .bottom)
    }
    
    public var leading: LayoutItem<LayoutDirection.Horizontal> {
        return LayoutItem(item: layoutable, attribute: .leading)
    }
    
    public var trailing: LayoutItem<LayoutDirection.Horizontal> {
        return LayoutItem(item: layoutable, attribute: .trailing)
    }
    
    public var width: LayoutItem<LayoutDirection.Size> {
        return LayoutItem(item: layoutable, attribute: .width)
    }
    
    public var height: LayoutItem<LayoutDirection.Size> {
        return LayoutItem(item: layoutable, attribute: .height)
    }
    
    public var centerX: LayoutItem<LayoutDirection.Horizontal> {
        return LayoutItem(item: layoutable, attribute: .centerX)
    }
    
    public var centerY: LayoutItem<LayoutDirection.Vertical> {
        return LayoutItem(item: layoutable, attribute: .centerY)
    }
    
    #if os(macOS)
    
    public func edges(equalTo other: Layoutable, insets: EdgeInsets = EdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) -> [NSLayoutConstraint] {
        return [
            left == other.layout.left + insets.left,
            right == other.layout.right - insets.left,
            
            top == other.layout.top + insets.top,
            bottom == other.layout.bottom - insets.bottom
        ]
    }
    
    #elseif os(iOS) || os(tvOS)
    
    public func edges(equalTo other: Layoutable, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        return [
            left == other.layout.left + insets.left,
            right == other.layout.right - insets.left,
            
            top == other.layout.top + insets.top,
            bottom == other.layout.bottom - insets.bottom
        ]
    }
    
    #endif
}


#if os(iOS) || os(tvOS)
    public extension Layout {
        public var leftMargin: LayoutItem<LayoutDirection.Horizontal> {
            return LayoutItem(item: layoutable, attribute: .leftMargin)
        }
        
        public var rightMargin: LayoutItem<LayoutDirection.Horizontal> {
            return LayoutItem(item: layoutable, attribute: .rightMargin)
        }
        
        public var topMargin: LayoutItem<LayoutDirection.Vertical> {
            return LayoutItem(item: layoutable, attribute: .topMargin)
        }
        
        public var bottomMargin: LayoutItem<LayoutDirection.Vertical> {
            return LayoutItem(item: layoutable, attribute: .bottomMargin)
        }
        
        public var leadingMargin: LayoutItem<LayoutDirection.Horizontal> {
            return LayoutItem(item: layoutable, attribute: .leadingMargin)
        }
        
        public var trailingMargin: LayoutItem<LayoutDirection.Horizontal> {
            return LayoutItem(item: layoutable, attribute: .trailingMargin)
        }
    }
#endif


public extension Layoutable {
    public var layout: Layout {
        return Layout(layoutable: self)
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

@available(OSX 10.10, iOS 8.0, tvOS 9.0, *)
public extension Sequence where Iterator.Element == NSLayoutConstraint {
    public func activate() {
        NSLayoutConstraint.activate(Array(self))
    }
    
    public func deactivate() {
        NSLayoutConstraint.activate(Array(self))
    }
}
