import SwiftUI

/// A fixed vertical space.
public struct VSpacer: View {
    public let height: CGFloat
    
    public init(_ height: CGFloat) {
        self.height = height
    }
    
    public var body: some View {
        Spacer().frame(height: height)
    }
}

/// A fixed horizontal space.
public struct HSpacer: View {
    public let width: CGFloat
    
    public init(_ width: CGFloat) {
        self.width = width
    }
    
    public var body: some View {
        Spacer().frame(width: width)
    }
}
