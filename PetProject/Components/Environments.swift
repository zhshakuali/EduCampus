import SwiftUI

public struct HideLabelEnvKey: EnvironmentKey {
    public static var defaultValue = false
}

public struct HideLabelIconEnvKey: EnvironmentKey {
    public static var defaultValue = false
}

public struct DisableHitTestEnvKey: EnvironmentKey {
    public static var defaultValue = false
}

public struct TintEnvironmentKey: EnvironmentKey {
    public static var defaultValue = Color.red
}

public struct TintSetterEnvironmentKey: EnvironmentKey {
    public static var defaultValue: (Color) -> Void = { _ in }
}

public extension EnvironmentValues {
    var labelHidden: Bool {
        get {
            self[HideLabelEnvKey.self]
        }
        set {
            self[HideLabelEnvKey.self] = newValue
        }
    }
    
    var labelIconHidden: Bool {
        get {
            self[HideLabelIconEnvKey.self]
        }
        set {
            self[HideLabelIconEnvKey.self] = newValue
        }
    }
    
    var hitTestDisabled: Bool {
        get {
            self[DisableHitTestEnvKey.self]
        }
        set {
            self[DisableHitTestEnvKey.self] = newValue
        }
    }
    
    var tint: Color {
        get {
            self[TintEnvironmentKey.self]
        }
        set {
            self[TintEnvironmentKey.self] = newValue
        }
    }
    
    var tintSetter: (Color) -> Void {
        get {
            self[TintSetterEnvironmentKey.self]
        }
        set {
            self[TintSetterEnvironmentKey.self] = newValue
        }
    }
}
