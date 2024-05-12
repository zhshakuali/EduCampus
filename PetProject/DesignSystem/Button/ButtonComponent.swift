import SwiftUI

struct ButtonComponent: View {
    
    let title: String
    let style: ButtonComponentStyle
    let isLoading: Bool
    let action: () -> Void
    
    var body: some View {
        Button(
            action: action,
            label: {
                Group {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text(title)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        )
        .buttonStyle(style)
        .disabled(isLoading)
    }
}

struct ButtonComponentStyle: ButtonStyle {
    
    @Environment(\.isEnabled)
    private var isEnabled: Bool
    
    @Environment(\.labelHidden)
    private var isLabelHidden
    
    @Environment(\.hitTestDisabled)
    private var hitTestDisabled
    
    @Environment(\.tintSetter)
    private var tintSetter
    
    var labelFont: Font
    var cornerRadius: CGFloat
    
    var stretched: Bool
    var height: CGFloat?
    
    var minEdges: EdgeInsets
    
    var iconSize: CGFloat
    let titleColor: (normal: Color, disabled: Color)
    let fill: (normal: Color, pressed: Color, disabled: Color)
    
    init(
        labelFont: Font = Defaults.labelFont,
        cornerRadius: CGFloat = Defaults.cornerRadius,
        stretched: Bool = false,
        height: CGFloat? = nil,
        minEdges: EdgeInsets = Defaults.minEdges,
        iconSize: CGFloat = Defaults.iconSize,
        titleColor: (normal: Color, disabled: Color),
        fill: (normal: Color, pressed: Color, disabled: Color)
    ) {
        self.labelFont = labelFont
        self.cornerRadius = cornerRadius
        self.stretched = stretched
        self.height = height
        self.minEdges = minEdges
        self.iconSize = iconSize
        self.titleColor = titleColor
        self.fill = fill
    }
    
    func fillStyle(configuration: Configuration) -> some View {
        if configuration.isPressed {
            return fill.pressed
        }
        
        if !isEnabled {
            return fill.disabled
        }
        
        return fill.normal
    }
    
    func label(configuration: Configuration) -> some View {
        configuration.label
            .labelStyle(
                ButtonLabelStyle(
                    iconSize: iconSize
                )
            )
            .font(labelFont)
            .lineLimit(1)
            .foregroundColor(
                isEnabled
                ? titleColor.normal
                : titleColor.disabled
            )
    }
    
    private func wrappedIfNeeded<V: View>(_ configuration: Configuration, @ViewBuilder _ view: () -> V) -> some View {
        Group {
            if stretched {
                ZStack {
                    fillStyle(configuration: configuration)
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                        .contentShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                    view()
                }
                .frame(height: height)
            } else {
                view()
                    .background(fillStyle(configuration: configuration))
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                    .contentShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                    .frame(height: height)
            }
        }
        .allowsHitTesting(!hitTestDisabled)
        .onAppear {
            tintSetter(titleColor.normal)
        }
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        wrappedIfNeeded(configuration) {
            VStack {
                VSpacer(minEdges.top)
                
                HStack {
                    HSpacer(minEdges.leading)
                    label(configuration: configuration)
                        .layoutPriority(0.9)
                    HSpacer(minEdges.trailing)
                }
                .layoutPriority(0.9)
                .isHidden(isLabelHidden)
                
                VSpacer(minEdges.bottom)
            }
        }
    }
}

extension ButtonComponentStyle {
    enum Defaults {
        public static let iconSize: CGFloat = 20
        public static let activityIndicatorSize: CGSize = .init(width: 24, height: 24)
        public static let labelFont: Font = .title2
        public static let cornerRadius: CGFloat = 16
        public static let height: CGFloat? = 56
        public static let minEdges = EdgeInsets(top: 11, leading: 12, bottom: 11, trailing: 12)
    }
}

struct ButtonLabelStyle: LabelStyle {
    
    @Environment(\.labelIconHidden)
    private var isLabelIconHidden
    
    let iconSize: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 8) {
            if !isLabelIconHidden {
                configuration.icon
                    .frame(width: iconSize, height: iconSize)
                    .frame(alignment: .leading)
                    .transition(.opacity.combined(with: .scale(scale: 0, anchor: .leading)))
            }
            configuration.title
        }
    }
}

extension ButtonStyle where Self == ButtonComponentStyle {
    
    static var primary: ButtonComponentStyle {
        ButtonComponentStyle(
            labelFont: .bodyLButtons,
            titleColor: (
                normal: .Text.primaryOnDark.color,
                disabled: .Text.secondary.color
            ),
            fill: (
                normal: .Background.brand.color,
                pressed: .Background.brandPressed.color,
                disabled: .Background.neutral1.color
            )
        )
    }
    
    static var secondary: ButtonComponentStyle {
        ButtonComponentStyle(
            labelFont: .bodyLButtons,
            titleColor: (
                normal: .Text.primary.color,
                disabled: .Text.secondary.color
            ),
            fill: (
                normal: .Background.neutral1.color,
                pressed: .Background.neutral2.color,
                disabled: .Background.neutral1.color
            )
        )
    }
}


extension ButtonComponentStyle {
    var standard: Self {
        var style = self
        style.labelFont = .bodyMBold
        style.height = 56
        style.cornerRadius = 12
        return style
    }
    
    var medium: Self {
        var style = self
        style.labelFont = .bodyMBold
        style.height = 48
        style.cornerRadius = 12
        return style
    }
    
    var small: Self {
        var style = self
        style.iconSize = 16
        style.labelFont = .bodyMBold
        style.height = 40
        style.cornerRadius = 12
        style.stretched = false
        return style
    }
}

#Preview {
    VStack {
        Button {
            
        } label: {
            Text("Button")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.primary)
        .padding()
        
        Button {
            
        } label: {
            Text("Button")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.secondary)
        .padding()
    }
}
