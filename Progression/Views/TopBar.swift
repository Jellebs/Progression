//
//  TopBar.swift
//  Progression
//
//  Created by Jesper Bertelsen on 06/09/2021.
//

import Foundation
import SwiftUI
struct TopBar<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        VStack {
            HStack {
                Button {
                    viewModel.excerciseViewIsActive.toggle()
                } label: {
                    WeightLogo(scale: 30)
                }
                Spacer()
                content
            }
            HStack {
                Spacer()
                VStack {
                    Text("Progression")
                        .font(.largeTitle)
                    Text("Keep it simple")
                        .font(.footnote)
                }
                Spacer()
            }
        }.padding(.bottom, 20)
    }
}
