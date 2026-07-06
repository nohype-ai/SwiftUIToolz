import SwiftUI
import Combine

public extension View {
    @inlinable func bind<P: Publisher>(_ binding: Binding<P.Output>,
                                       to publisher: P,
                                       animated: Bool = false) -> some View where P.Failure == Never {
        onReceive(publisher) { value in
            if animated {
                withAnimation { binding.wrappedValue = value }
            } else {
                binding.wrappedValue = value
            }
        }
    }
}
