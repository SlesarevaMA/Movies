//
//  View+.swift
//  Movies
//
//  Created by Margarita Slesareva on 01.06.2023.
//

import SwiftUI

extension VStack {
    static func zeroSpacing(@ViewBuilder content: () -> Content) -> VStack {
        return VStack(alignment: .leading, spacing: 0, content: content)
    }
}

extension HStack {
    static func zeroSpacing(@ViewBuilder content: () -> Content) -> HStack {
        return HStack(alignment: .top, spacing: 0, content: content)
    }
}
