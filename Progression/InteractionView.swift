//
//  InteractionView.swift
//  Progression
//
//  Created by Jesper Bertelsen on 20/09/2021.
//

import SwiftUI

struct InteractionView<Content:View>: View, KeyboardReadable {
    @Environment(\.colorScheme) var colorScheme
    @Binding var isActive: Bool
    let content: Content
    let height: CGFloat
    init(isActive: Binding<Bool>, height: CGFloat = 200, @ViewBuilder content: () -> Content) {
        self.content = content()
        _isActive = isActive
        self.height = height
    }
    @State var isKeyboardShown: Bool = false
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
                        .padding(.bottom, isKeyboardShown ? 300 : 0)
                        
                }.mask(RoundedRectangle(cornerRadius: 12))
                .frame(height: isKeyboardShown ? height + 300 : height)
                .onReceive(keyboardPublisher) { info in
                    isKeyboardShown = info
                }
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .topDownColorSettings()
                )
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }.offset(y: 10).ignoresSafeArea()
    }
}
