import AppKit
import SwiftyToolz

public extension LayerBackedView
{
    @available(macOS 11, *)
    func set(backgroundColor: SwiftyToolz.Color)
    {
        let cgColor = CGColor(red: backgroundColor.red,
                              green: backgroundColor.green,
                              blue: backgroundColor.blue,
                              alpha: backgroundColor.alpha)
        
        layer?.backgroundColor = cgColor
    }
}
