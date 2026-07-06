#if os(macOS)
import SwiftUI

public extension NSApplication
{
    /// Just call this on `NSApp`
    func toggleSidebar()
    {
        // https://stackoverflow.com/questions/61771591/toggle-sidebar-in-swiftui-navigationview-on-macos
        sendAction(#selector(NSSplitViewController.toggleSidebar(_:)),
                   to: nil,
                   from: nil)
    }
    
    /// Just call this on `NSApp`
    func toggleFullscreen()
    {
        keyWindow?.toggleFullScreen(nil)
    }
}
#endif
