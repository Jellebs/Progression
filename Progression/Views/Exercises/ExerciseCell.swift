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
    @State var exercise: Excercise
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                viewModel.currentExercise = exercise
                isActive.toggle()
            } label: {
            Rectangle()
                .secondaryColorSetting()
                
                .overlay(
                    CellView({ viewModel.exerciseForDeletion(exercise)}) {
                        VStack {
                            HStack {
                                Text(exercise.name).font(.title)
                                    .foregroundColor(colorScheme == .dark ? .black : .black)
                                Spacer()
                                    
                            }.padding(.horizontal)
                            
                            if isActive {
                                Graph().frame(height: 300)
                            }
                        }
                        
                    }
                )
                
            }
            
        }
        .frame(height: isActive ? 390 : 90)
        .onChange(of: viewModel.currentExercise) { _ in
            if viewModel.currentExercise?.id != exercise.id {
                isActive = false
            }
        }
    }
}

struct ExcerciseCell_Previews: PreviewProvider {
    
    static var previews: some View {
        ExerciseCell(exercise: Excercise())
    }
}
