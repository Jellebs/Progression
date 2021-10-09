//
//  InteractionView.swift
//  Progression
//
//  Created by Jesper Bertelsen on 20/09/2021.
//

import SwiftUI

struct InteractionView<Content:View>: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var isActive: Bool
    let content: Content
    let height: CGFloat
    init(isActive: Binding<Bool>, height: CGFloat = 200, @ViewBuilder content: () -> Content) {
        self.content = content()
        _isActive = isActive
        self.height = height
    }
    var body: some View {
        ZStack {
            Button {
                isActive.toggle()
            } label: {
                Color.clear
                    .blur(radius: 4)
            }
            VStack {
                Spacer()
                HStack {
                    content
                }.mask(RoundedRectangle(cornerRadius: 12))
                .frame(height: height)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .topDownColorSettings()
                )
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }.ignoresSafeArea()
    }
}
