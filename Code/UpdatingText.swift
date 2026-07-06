import SwiftUI
import Combine

/// A text view that is directly bound to a `String` publisher.
///
/// It manages its own `@State` property to the following benefits:
/// 1. Views don't have to hold and update a `@State` property for each of their `Text` views.
/// 2. Single Source of Truth: Initial values can't differ between observed object and view state.
/// 3. State changes trigger only the corresponding `Text` view to update – not its whole parent view.
///
/// So, in a `View`, instead of
/// ```swift
/// var body: some View {
///     Text(text)
///         .onReceive(Model.shared.stringPublisher) {
///             text = $0
///         }
/// }
///
/// // if `stringPublisher`, is a `Publisher` that doesn't fire on connect (like a `PassThroughSubject`), we show this arbitrary initial view state
/// // Also: When stringPublisher fires, this whole view updates
/// @State private var text = "initial view state"
/// ```
/// you could write
/// ```swift
/// var body: some View {
///     UpdatingText(Model.shared.stringPublisher)
/// }
/// ```
///
/// To modify the `Text` view, simply pass a closure that does it:
/// ```swift
/// var body: some View {
///     UpdatingText(Model.shared.stringPublisher) {
///         $0.bold()
///     }
/// }
/// ```
public struct UpdatingText<P: Publisher>: View where P.Output == String, P.Failure == Never {
    public init(_ publisher: P,
                initialText: String = "",
                modify: ((Text) -> Text)? = nil) {
        self.publisher = publisher
        self.modify = modify ?? { $0 }
        self._text = State(initialValue: initialText)
    }
    
    public var body: some View {
        modify(Text(text)).bind($text, to: publisher)
    }
    
    @State private var text: String
    private let publisher: P
    private let modify: (Text) -> Text
}
