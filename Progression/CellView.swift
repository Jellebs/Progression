//
//  CellView.swift
//  Progression
//
//  Created by Jesper Bertelsen on 28/09/2021.
//

import SwiftUI

struct CellView<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    let content: Content
    let onLeftSwipe: () -> Void
    let padding: CGFloat = 40
    init(_ onLeftSwipe: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.onLeftSwipe = { onLeftSwipe } ()
        self.content = content()
    }
    @State var sliderPosition: CGFloat = 0
    @GestureState var offset = CGSize.zero
    
    //checkMarks
    let first: CGFloat = 0.15
    let second: CGFloat = 0.65
    var body: some View {
        ZStack {
            GeometryReader { geo in
                Rectangle().foregroundColor(.red)
                    .frame(maxHeight: .infinity)
                let size: CGFloat = 50
                Image(systemName: "trash.fill")
                    .resizable()
                    .frame(width: size, height: size)
                    .offset(x: geo.size.width * (1-first) - size/2, y: geo.size.height * 0.5 - size/2)
                    .foregroundColor(.white)
                    .onTapGesture {
                        onLeftSwipe()
                    }
                content
                    .frame(maxHeight: .infinity)
                    .background(Rectangle()
                                    .secondaryColorSetting())
                    .offset(x: offset.width+sliderPosition)
                    .gesture(
                        DragGesture()
                            .updating($offset, body: { (value, state, transaction) in
                                if value.translation.width < 0 {
                                    state = value.translation
                                }
                                if value.translation.width + sliderPosition < -geo.size.width * second {
                                    onLeftSwipe()
                                }
                            }
                            )
                            .onEnded { value in
                                // to left
                                if value.translation.width < -geo.size.width * first {
                                    sliderPosition = -geo.size.width * (first + first)
                                } else {
                                    sliderPosition = 0
                                }
                            }
                    )
            }
        }.background(Rectangle().shadowSettings()
        )
    }
}
