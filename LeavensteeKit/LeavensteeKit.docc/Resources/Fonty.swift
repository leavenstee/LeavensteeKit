//
//  Fonty.swift
//  IsItShittyOut
//
//  Created by Steven Lee on 1/31/21.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
struct Fonty: ViewModifier {
    
    @Environment(\.sizeCategory) var sizeCategory
    
    public enum TextStyle {
        case megaTitle
        case bigTitle
        case title
        case body
        case description
    }
    
    var textStyle: TextStyle

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
       return content.font(.custom(fontName, size: scaledSize))
    }
    
    private var fontName: String {
        switch textStyle {
        case .title, .bigTitle, .megaTitle:
            return "Futura-Bold"
        case .body, .description:
            return "Futura-Medium"
        }
    }
    
    private var size: CGFloat {
        switch textStyle {
        case .megaTitle:
            return 84
        case .bigTitle:
            return 42
        case .title:
            return 36
        case .body:
            return 24
        case .description:
            return 16
        }
    }
}

@available(iOS 13.0, *)
extension View {
    @available(iOS 13.0, *)
    func setFonty(_ textStyle: Fonty.TextStyle) -> some View {
        self.modifier(Fonty(textStyle: textStyle))
    }
}
