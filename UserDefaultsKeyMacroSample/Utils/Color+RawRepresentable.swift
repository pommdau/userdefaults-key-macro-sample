//
//  Color+RawRepresentable.swift
//  Peelable Sticky
//
//  Created by HIROKI IKEUCHI on 2023/12/18.
//

import SwiftUI

struct ColorData {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
}

/// refs: [SwiftUI: Colorを@AppStorageで保存できるようにする](https://zenn.dev/kyome/articles/3f6ee868c52b15)
extension NSColor {
    var rgba: ColorData {
        var r: CGFloat = .zero
        var g: CGFloat = .zero
        var b: CGFloat = .zero
        var a: CGFloat = .zero
        if let color = self.usingColorSpace(.sRGB) {
            color.getRed(&r, green: &g, blue: &b, alpha: &a)
        }
        return ColorData(red: r, green: g, blue: b, alpha: a)
    }
}

extension Color {
    var rgbaValues: ColorData {
        let rgba = NSColor(self).rgba
        return ColorData(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
    }
}

extension Color: RawRepresentable {

    public typealias RawValue = String

    public var rawValue: String {
        let rgba = self.rgbaValues
        let r = String(format: "%0.8f", rgba.red)
        let g = String(format: "%0.8f", rgba.green)
        let b = String(format: "%0.8f", rgba.blue)
        let o = String(format: "%0.8f", rgba.alpha)
        return [r, g, b, o].joined(separator: ",")
    }
    
    public init?(rawValue: String) {
        let components = rawValue.components(separatedBy: ",")
        let r = Double(components[0]) ?? .zero
        let g = Double(components[1]) ?? .zero
        let b = Double(components[2]) ?? .zero
        let o = Double(components[3]) ?? .zero
        self = .init(.sRGB, red: r, green: g, blue: b, opacity: o)
    }
}
