//
//  ColorTheme.swift
//  concertapp
//
//  Created by Adriaan Vander Elst on 16/08/2024.
//

import SwiftUI

struct ColorTheme {
    let primary = Color("Primary")
    let secondary = Color("Secondary")
    let accent = Color("Accent")
    let background = LinearGradient(gradient: Gradient(colors: [Color("Background_L"), Color("Background_R")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    let red = Color("Red")
    let green = Color("Green")
    let white = Color("White")
}

extension Color {
    static let theme = ColorTheme()
}
