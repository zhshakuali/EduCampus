import SwiftUI

public protocol LoadingIndicatable {
    associatedtype SomeBody : View
    
    @ViewBuilder func loading(
        _ loading: Bool
    ) -> SomeBody
}

struct LoadableModifier: ViewModifier {
    
    var loading: Bool
    
    func body(content: Content) -> some View {
        Group {
            content
                .overlay {
                    if loading {
                        loader
                    }
                }
        }
        .environment(\.labelHidden, loading)
        .environment(\.hitTestDisabled, loading)
    }
    
    var loader: some View {
        ProgressView()
    }
}

extension Button: LoadingIndicatable {
    public func loading(
        _ loading: Bool
    ) -> some View {
        self.modifier(
            LoadableModifier(
                loading: loading
            )
        )
    }
}
