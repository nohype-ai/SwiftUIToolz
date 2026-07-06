import SwiftUI

/// A simple navigation link without a chevron
public struct PlainNavigationLink<Label: View, Destination: View>: View {
    public init(destination: Destination, label: @escaping () -> Label) {
        self.destination = destination
        self.label = label
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            label()
            NavigationLink(destination: destination) {
                EmptyView()
            }
            .opacity(0)
        }
    }
    
    public let destination: Destination
    
    @ViewBuilder
    public let label: () -> Label
}

/// An isolated navigation link chevron
@available(macOS 11.0, *)
public struct NavigationChevron: View {
    public init() { }
    
    public var body: some View {
        Image(systemName: "chevron.forward")
            .imageScale(.small)
            .foregroundColor(color)
            .font(.body.weight(.semibold))
    }
    
    private var color: Color {
        #if os(iOS)
        return Color(UIColor.systemGray3)
        #else
        return Color(NSColor.systemGray)
        #endif
    }
}
