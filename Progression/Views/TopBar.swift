//
//  TopBar.swift
//  Progression
//
//  Created by Jesper Bertelsen on 06/09/2021.
//

import Foundation
import SwiftUI
struct TopBar: View {
    @Environment(\.colorScheme) var colorScheme
    let onPlusButton: () -> Void
    init(_ onPlusButton: @escaping () -> Void) {
        self.onPlusButton = { onPlusButton } ()
    }
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        VStack {
            HStack {
                Button {
                    viewModel.exerciseViewIsActive.toggle()
                } label: {
                    WeightLogo(scale: 30)
                }
                Spacer()
                Button {
                    onPlusButton()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .clipped()
                        .frame(width: 20, height: 20)
                }
            }
            HStack {
                Spacer()
                VStack {
                    Text("Progression")
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                    Text("Keep it simple")
                        .font(.footnote)
                        .foregroundColor(.primary)
                }
                Spacer()
            }
        }.padding(.bottom, 20)
    }
}
