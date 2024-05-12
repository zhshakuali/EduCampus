import SwiftUI
import UIKit

private struct TouchModifier: ViewModifier {
    @Binding var isPressed: Bool
    let isEnabled: Bool
    let onEnded: () -> Void
    let onCancelled: (() -> Void)?

    @ViewBuilder
    func body(content: Content) -> some View {
        content.overlay {
            TouchRecognizingView(
                isEnabled: isEnabled,
                isPressed: $isPressed,
                onEnded: onEnded,
                onCancelled: onCancelled
            )
        }
    }
}

struct TouchRecognizingView: UIViewRepresentable {
    private let isEnabled: Bool
    @Binding var isPressed: Bool
    private let onEnded: () -> Void
    private let onCancelled: (() -> Void)?
    
    init(
        isEnabled: Bool = true,
        isPressed: Binding<Bool>,
        onEnded: @escaping () -> Void,
        onCancelled: (() -> Void)? = nil
    ) {
        self.isEnabled = isEnabled
        _isPressed = isPressed
        self.onEnded = onEnded
        self.onCancelled = onCancelled
    }
    
    func makeUIView(context: Context) -> TouchRecognizingUIView {
        TouchRecognizingUIView(
            onPressed: { isPressed = $0 },
            onEnded: onEnded,
            onCancelled: onCancelled
        )
    }
    
    func updateUIView(_ uiView: TouchRecognizingUIView, context: Context) {
        uiView.isTouchAnimationEnabled = isEnabled
        uiView.onEnded = onEnded
        uiView.onCancelled = onCancelled
        
        let stateManager = context.environment[TouchGestureStateManagerKey.self]
        stateManager.onEnd = { [weak uiView] in
            uiView?.endTouchAnimation()
        }
        stateManager.onCancel = { [weak uiView] in
            uiView?.cancelTouchAnimation()
        }
    }
}

final class TouchRecognizingUIView: UIView {
    
    var isTouchAnimationEnabled = true {
        didSet {
            isTouchAnimationEnabled ? enableTouchAnimation() : disableTouchAnimation()
        }
    }
    
    private let onPressed: (Bool) -> Void
    var onEnded: () -> Void
    var onCancelled: (() -> Void)?
    
    private var recognizer: UIGestureRecognizer?
    
    init(
        onPressed: @escaping (Bool) -> Void,
        onEnded: @escaping () -> Void,
        onCancelled: (() -> Void)?
    ) {
        self.onPressed = onPressed
        self.onEnded = onEnded
        self.onCancelled = onCancelled
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) { fatalError("Error") }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isTouchAnimationEnabled = true
    }
    
    func enableTouchAnimation() {
        recognizer = addTouchGestureRecognizer { [unowned self] recognizer in
            switch recognizer.state {
            case .began:
                onPressed(true)
            case .ended:
                onPressed(false)
                onEnded()
            case .cancelled, .failed:
                onPressed(false)
                onCancelled?()
            default:
                return
            }
        }
    }
    
    func disableTouchAnimation() {
        removeTouchGestureRecognizer()
        recognizer = nil
    }
    
    func cancelTouchAnimation() {
        recognizer?.state = .cancelled
    }
    
    func endTouchAnimation() {
        recognizer?.state = .ended
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if isTouchAnimationEnabled {
            return super.point(inside: point, with: event)
        } else {
            return false
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isTouchAnimationEnabled {
            return super.hitTest(point, with: event)
        } else {
            return nil
        }
    }
    
    @discardableResult
    private func addTouchGestureRecognizer(
        action: @escaping (UIGestureRecognizer) -> Void
    ) -> UIGestureRecognizer {
        if let recognizer = gestureRecognizers?.first(where: { $0 is TouchGestureRecognizer }) {
            return recognizer
        }
        
        let recognizer = TouchGestureRecognizer(treshold: 10, action: action)
        recognizer.cancelsTouchesInView = false
        addGestureRecognizer(recognizer)
        
        return recognizer
    }
    
    private func removeTouchGestureRecognizer() {
        guard let recognizer = gestureRecognizers?.first(where: { $0 is TouchGestureRecognizer }) else { return }
        
        removeGestureRecognizer(recognizer)
    }
    
}

class TouchGestureRecognizer: UIGestureRecognizer {
    
    private let treshold: CGFloat
    private let action: (UIGestureRecognizer) -> Void
    
    private var startPoint: CGPoint?
    
    init(treshold: CGFloat, action: @escaping (UIGestureRecognizer) -> Void) {
        self.treshold = treshold
        self.action = action
        
        super.init(target: nil, action: nil)
        
        addTarget(self, action: #selector(onTouch))
    }
    
    @objc
    private func onTouch() {
        action(self)
    }
    
    override func canPrevent(_ preventedGestureRecognizer: UIGestureRecognizer) -> Bool {
        false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first, let view = touch.view, !(view is UIControl) else { return }
        
        state = .began
        startPoint = touch.location(in: view)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        
        guard let view, let point = touches.first?.location(in: view) else {
            return
        }
        
        if view.bounds.contains(point), distance(from: startPoint ?? .zero, to: point) < treshold {
            state = .possible
        } else {
            state = .cancelled
            startPoint = nil
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        
        state = .ended
        startPoint = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        
        state = .cancelled
        startPoint = nil
    }
    
    private func distance(from: CGPoint, to: CGPoint) -> CGFloat {
        sqrt((from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y))
    }
}

public final class TouchGestureStateManager: ObservableObject {
    fileprivate var onEnd: (() -> Void)?
    fileprivate var onCancel: (() -> Void)?
    
    public init() {}
    
    public func end() {
        onEnd?()
    }
    
    public func cancel() {
        onCancel?()
    }
}

public struct TouchGestureStateManagerKey: EnvironmentKey {
    public static var defaultValue: TouchGestureStateManager {
        TouchGestureStateManager()
    }
}

public extension EnvironmentValues {
    var touchGestureStateManager: TouchGestureStateManager {
        get { self[TouchGestureStateManagerKey.self] }
        set { self[TouchGestureStateManagerKey.self] = newValue }
    }
}


public extension View {

    /// Adds a gesture recognizer that subscribes for any touch in a view.
    /// - Parameters:
    ///   - isPressed: The current state determinimg whether the view is touched or not.
    ///   - onEnded: Called when touches are ended inside the view area.
    ///   - onCancelled: Called when touches are cancelled or ended outside the view area.
    /// - Returns: The modified view.
    func onTouchGesture(
        isPressed: Binding<Bool>,
        isEnabled: Bool = true,
        onEnded: @escaping () -> Void,
        onCancelled: (() -> Void)? = nil
    ) -> some View {
        modifier(
            TouchModifier(
                isPressed: isPressed,
                isEnabled: isEnabled,
                onEnded: onEnded,
                onCancelled: onCancelled
            )
        )
    }
}
