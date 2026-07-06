import SwiftUI
import CombineObserver
import Combine
import SwiftObserver

public extension View {
    func bind<O: ObservableCache>(_ binding: Binding<O.Message>,
                                  to observable: O) -> some View {
        bind(binding, to: observable.publisher())
    }
    
    func bind<O: SwiftObserver.ObservableObject>(_ binding: Binding<O.Message>,
                             to observable: O) -> some View {
        bind(binding, to: observable.publisher())
    }
}
