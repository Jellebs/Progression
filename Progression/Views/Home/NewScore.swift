//
//  NewScore.swift
//  Progression
//
//  Created by Jesper Bertelsen on 06/09/2021.
//

import SwiftUI

struct NewScore: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var selectedExercise: Excercise?
    var body: some View {
        VStack {
            if selectedExercise != nil {
                HStack {
                    Picker("Exercises", selection: $selectedExercise) {
                        ForEach(viewModel.exercises, id: \.self) { excercise in
                            PickerCell(excercise: excercise)
                                
                        }
                    }
                    Spacer()
                    Button {
                        if !viewModel.hasConfigured() { viewModel.configure() }
                        viewModel.addScore(excercise: selectedExercise!)
                        viewModel.newScoreIsActive.toggle()
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.title2)
                    }
                    .foregroundColor(.black)
                }.padding()
            } else {
                HStack {
                    Text("No exercises yet made")
                }
            }
        }.frame(maxWidth: .infinity)
    }
}

//struct NewScore_Previews: PreviewProvider {
//    static var previews: some View {
//        NewScore()
//    }
//}
