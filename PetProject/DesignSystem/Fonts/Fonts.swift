import SwiftUI

enum AppFontWeight {
    
    case design800
    case design700
    case design600
    case design500
    case design400
    
    var nativeWeight: Font.Weight {
        switch self {
        case .design800:
            return .heavy
        case .design700:
            return .bold
        case .design600:
            return .semibold
        case .design500:
            return .medium
        case .design400:
            return .regular
        }
    }
    
    var uiKitNativeWeight: UIFont.Weight {
        switch self {
        case .design800:
            return .heavy
        case .design700:
            return .bold
        case .design600:
            return .semibold
        case .design500:
            return .medium
        case .design400:
            return .regular
        }
    }
    
}

extension Font {
    
    static func appFont(size: CGFloat, weight: AppFontWeight, design: Design) -> Font {
        system(size: size, weight: weight.nativeWeight, design: design)
    }
    
}

extension UIFont {
    
    static func appFont(size: CGFloat, weight: AppFontWeight) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: weight.uiKitNativeWeight)
    }
    
}

public extension Font {
    
    // MARK: - Headings
    
    /// Main title for cashback
    static let headingCaps = appFont(size: 30, weight: .design800, design: .default)
    
    /// Amounts on Success / Transactions
    static let headingXL = appFont(size: 44, weight: .design700, design: .default)
    
    /// Main titles
    static let headingL = appFont(size: 34, weight: .design700, design: .default)
    
    /// Main titles in small screens
    static let headingLM = appFont(size: 26, weight: .design700, design: .default)
    
    /// Card / Widget titles
    static let headingM = appFont(size: 20, weight: .design700, design: .default)
    
    /// Small card / Offers titles
    static let headingS = appFont(size: 17, weight: .design700, design: .default)
    
    static let headingXS = appFont(size: 15, weight: .design600, design: .default)
    
    // MARK: - Body
    
    /// Subheadings for Heading L.
    static let bodyL = appFont(size: 17, weight: .design400, design: .default)
    
    static let bodyLSemibold = appFont(size: 17, weight: .design600, design: .default)
    
    static let bodyLBold = appFont(size: 17, weight: .design700, design: .default)
    
    /// Buttons, Text Buttons.
    static let bodyLButtons = appFont(size: 17, weight: .design500, design: .default)
    
    /// Subheadings for Heading M, regular text for Cards.
    static let bodyM = appFont(size: 15, weight: .design400, design: .default)
    
    static let bodyMBold = appFont(size: 15, weight: .design600, design: .default)
    
    static let bodyS = appFont(size: 13, weight: .design400, design: .default)
    
    static let bodySBold = appFont(size: 13, weight: .design600, design: .default)
    
}

public extension UIFont {
    static let bodyS = appFont(size: 13, weight: .design400)
    /// Subheadings for Heading M, regular text for Cards.
    static let bodyM = appFont(size: 15, weight: .design400)
    /// Subheadings for Heading M, regular text for Cards.
    static let bodyMBold = appFont(size: 15, weight: .design600)
    /// Subheadings for Heading L.
    static let bodyL = appFont(size: 17, weight: .design400)
}
