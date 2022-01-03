//
//  Unwrap.swift
//  IsItShittyOut
//
//  Created by Steven Lee on 2/2/21.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
struct Unwrap<Value, Content: View>: View {
    private let value: Value?
    private let contentProvider: (Value) -> Content

    init(
        _ value: Value?,
         @ViewBuilder content: @escaping (Value) -> Content
    ) {
        self.value = value
        self.contentProvider = content
    }

    var body: some View {
        value.map(contentProvider)
    }
}
