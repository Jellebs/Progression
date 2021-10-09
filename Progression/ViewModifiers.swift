//
//  ViewModifiers.swift
//  Progression
//
//  Created by Jesper Bertelsen on 27/09/2021.
//

import SwiftUI
//Saturation -0.05 i dark mode

struct PrimaryOppositeColorSetting: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        if colorScheme == .light {
            content
                .primaryColorSetting()
                .saturation(1.5)
                .brightness(0.3)
        } else {
            content
                .primaryColorSetting()
                .saturation(1.5)
                .brightness(0.2)
        }
        
    }
}
struct SecondaryOppositeColorSetting: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        if colorScheme == .light {
            content
                .secondaryColorSetting()
                .brightness(0.5)
        } else {
            content
                .secondaryColorSetting()
                .brightness(0.4)
        }
        
    }
}
struct PrimararyColorSetting: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        if colorScheme == .light {
            content
                .foregroundColor(.accentColor)
                .saturation(0.8)
                .brightness(0.2)
        } else {
            content
                .foregroundColor(.accentColor)
                .saturation(0.75)
        }
        
    }
}
struct SecondaryColorSetting: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    let foregroundColor: Color = Color(hue: 0, saturation: 0.44, brightness: 1)
    
    
    
    func body(content: Content) -> some View {
        if colorScheme == .light {
            content
                .foregroundColor(.accentColor)
                .saturation(0.7)
                .brightness(0.2)
        } else {
            content
                .foregroundColor(.accentColor)
                .saturation(0.65)
        }
    }
}
struct TertiaryColorSetting: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        if colorScheme == .light {
            content
                .foregroundColor(.accentColor)
                .saturation(0.4)
                .brightness(0.2)
        } else {
            content
                .saturation(0.35)
        }
    }
}
struct TopDownColorSettings: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .foregroundColor(.accentColor)
            .brightness(colorScheme == .dark ? 0.15 : 0.10)
            .saturationFade(0.8,
                            startPoint: .bottom,
                            endPoint: .top)
    }
}

struct ShadowSettings: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        if colorScheme == .light {
            content
                .shadow(color: .gray, radius: 4, x: 0, y: 2)
        } 
    }
}

