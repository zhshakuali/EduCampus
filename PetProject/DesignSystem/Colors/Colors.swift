import UIKit
import SwiftUI

extension Color: RawRepresentable {
    public init?(rawValue: Color) {
        self = rawValue
    }
    
    public var rawValue: Self {
        self
    }
}

extension Color {
    
    enum Foreground: String, CaseIterable {
        case secondary
        
        var color: Color {
            switch self {
            case .secondary:
                let any = #colorLiteral(red: 0.09019607843, green: 0.1098039216, blue: 0.1490196078, alpha: 0.45)
                let dark = #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 0.45)
                return Color(anyModeColor: any, darkModeColor: dark)
            }
        }
    }
    
    enum Text: String, CaseIterable {
        case primary
        case secondary
        case tertiary
        case primaryOnDark
        
        var color: Color {
            switch self {
            case .primary:
                let any = #colorLiteral(red: 0.07058823529, green: 0.07843137255, blue: 0.0862745098, alpha: 1)
                let dark = #colorLiteral(red: 0.9490196078, green: 0.9568627451, blue: 0.9725490196, alpha: 1)
                return Color(anyModeColor: any, darkModeColor: dark)
            case .secondary:
                let any = #colorLiteral(red: 0.09019607843, green: 0.1098039216, blue: 0.1490196078, alpha: 0.45)
                let dark = #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 0.45)
                return Color(anyModeColor: any, darkModeColor: dark)
            case .tertiary:
                let any = #colorLiteral(red: 0, green: 0.04705882353, blue: 0.1411764706, alpha: 0.22)
                let dark = #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 0.25)
                return Color(anyModeColor: any, darkModeColor: dark)
            case .primaryOnDark:
                let any = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                let dark = #colorLiteral(red: 0.9137254902, green: 0.9098039216, blue: 0.9333333333, alpha: 1)
                return Color(anyModeColor: any, darkModeColor: dark)
            }
        }
    }
    
    enum Background: String, CaseIterable {
        case elevation
        case base
        case neutral1
        case neutral2
        case brand
        case brandPressed
        case accent
        case accentPressed
        
        var color: Color {
            switch self {
            case .elevation:
                let elevationAny = #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.9764705882, alpha: 1)
                let elevationDark = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                return Color(anyModeColor: elevationAny, darkModeColor: elevationDark)
            case .base:
                let baseAny = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                let baseDark = #colorLiteral(red: 0.09803921569, green: 0.1019607843, blue: 0.1098039216, alpha: 1)
                return Color(anyModeColor: baseAny, darkModeColor: baseDark)
            case .neutral1:
                let any = #colorLiteral(red: 0, green: 0.1450980392, blue: 0.4392156863, alpha: 0.04)
                let dark = #colorLiteral(red: 0.6823529412, green: 0.7058823529, blue: 0.7607843137, alpha: 0.1)
                return Color(anyModeColor: any, darkModeColor: dark)
            case .neutral2:
                let any = #colorLiteral(red: 0.1294117647, green: 0.2352941176, blue: 0.4392156863, alpha: 0.11)
                let dark = #colorLiteral(red: 0.6862745098, green: 0.7098039216, blue: 0.7647058824, alpha: 0.15)
                return Color(anyModeColor: any, darkModeColor: dark)
            case .brand:
                let any = #colorLiteral(red: 0.9176470588, green: 0.368627451, blue: 0.3843137255, alpha: 1)
                let dark = #colorLiteral(red: 0.8980392157, green: 0.368627451, blue: 0.3843137255, alpha: 1)
                return Color(anyModeColor: any, darkModeColor: dark)
            case .brandPressed:
                let any = #colorLiteral(red: 0.8509803922, green: 0.2784313725, blue: 0.3843137255, alpha: 1)
                let dark = #colorLiteral(red: 0.8509803922, green: 0.2039215686, blue: 0.2784313725, alpha: 1)
                return Color(anyModeColor: any, darkModeColor: dark)
            case .accent:
                let any = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                let dark = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
                return Color(anyModeColor: any, darkModeColor: dark)
            case .accentPressed:
                let any = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                let dark = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
                return Color(anyModeColor: any, darkModeColor: dark)
            }
        }
    }
}

#Preview {
    ColorPreview()
}

private struct ColorPreview: View {
    var body: some View {
        List {
            sectionView("Foreground") {
                ForEach(Color.Foreground.allCases, id: \.self) { color in
                    colorView(color.color, color.rawValue)
                }
            }
            
            sectionView("Background") {
                ForEach(Color.Background.allCases, id: \.self) { color in
                    colorView(color.color, color.rawValue)
                }
            }
            
            sectionView("Text") {
                ForEach(Color.Text.allCases, id: \.self) { color in
                    colorView(color.color, color.rawValue)
                }
            }
        }
    }
    
    func sectionView<Content: View>(_ title: String, content: () -> Content) -> some View {
        Section(title) {
            VStack(alignment: .leading, spacing: 10) {
                content()
            }
            .padding()
        }
    }
    
    func colorView(_ color: Color, _ desc: String) -> some View {
        HStack {
            color
                .frame(width: 56, height: 56)
                .clipped()
            Text(desc)
        }
    }
}

private extension View {
    func colorBorder() -> AnyView {
        AnyView(
            ZStack {
                self
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.Foreground.secondary.color)
            }
        )
    }
}

private extension Color {
    init(anyModeColor: UIColor, darkModeColor: UIColor) {
        self.init(
            uiColor: .init(
                anyModeColor: anyModeColor,
                darkModeColor: darkModeColor
            )
        )
    }
    
    init(
        anyModeColor: UIColor,
        darkModeColor: UIColor,
        elevatedAnyModeColor: UIColor,
        elevatedDarkModeColor: UIColor
    ) {
        self.init(
            uiColor: .init(
                anyModeColor: anyModeColor,
                darkModeColor: darkModeColor,
                elevatedAnyModeColor: elevatedAnyModeColor,
                elevatedDarkModeColor: elevatedDarkModeColor
            )
        )
    }
}

private extension Color {
    init(_colorLiteralRed: Float, green: Float, blue: Float, alpha: Float) {
        self.init(.sRGB, red: Double(_colorLiteralRed), green: Double(green), blue: Double(blue), opacity: Double(alpha))
    }
}

private extension UIColor {
    convenience init(anyModeColor: UIColor, darkModeColor: UIColor) {
        self.init { traitCollection -> UIColor in
            traitCollection.userInterfaceStyle == .dark ? darkModeColor : anyModeColor
        }
    }
    
    convenience init(
        anyModeColor: UIColor,
        darkModeColor: UIColor,
        elevatedAnyModeColor: UIColor,
        elevatedDarkModeColor: UIColor
    ) {
        self.init { traitColection in
            if traitColection.userInterfaceLevel == .elevated {
                return traitColection.userInterfaceStyle == .dark ? elevatedDarkModeColor : elevatedAnyModeColor
            } else {
                return traitColection.userInterfaceStyle == .dark ? darkModeColor : anyModeColor
            }
        }
    }
}
