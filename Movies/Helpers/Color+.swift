//
//  Color+.swift
//  Movies
//
//  Created by Margarita Slesareva on 31.05.2023.
//

import SwiftUI

extension Color {
    init(hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0
        )
    }
}
