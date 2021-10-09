//
//  ExcerciseCell.swift
//  Progression
//
//  Created by Jesper Bertelsen on 06/09/2021.
//

import SwiftUI

struct ExerciseCell: View {
    @Environment(\.colorScheme) var colorScheme
    @State var isActive: Bool = false
    @EnvironmentObject var viewModel: ViewModel
    @State var excercise: Excercise
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                viewModel.currentExercise = excercise
                isActive.toggle()
            } label: {
            RoundedRectangle(cornerRadius: 8)
                .secondaryColorSetting()
                .overlay(
                    HStack { Text(excercise.name).font(.title).foregroundColor(colorScheme == .dark ? .black : .black); Spacer() }.padding()
                )
            }
            if isActive {
                Graph().frame(height: 300)
            }
        }
        .onChange(of: viewModel.currentExercise) { _ in
            if viewModel.currentExercise?.id != excercise.id {
                isActive = false
            }
        }
        .frame(height: isActive ? 380 : 80)
        .multilineTextAlignment(.leading)
    }
}

struct ExcerciseCell_Previews: PreviewProvider {
    
    static var previews: some View {
        ExerciseCell(excercise: Excercise())
    }
}
