//
//  NewScore.swift
//  Progression
//
//  Created by Jesper Bertelsen on 06/09/2021.
//

import SwiftUI

struct NewScore: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var selectedExcercise: Excercise
    var body: some View {
        VStack {
            HStack {
                Picker("Excercises", selection: $selectedExcercise) {
                    ForEach(viewModel.excercises, id: \.self) { excercise in
                        Text(excercise.name).tag(excercise.self).foregroundColor(.white)
                            .font(.title2)
                    }
                }
                Spacer()
                Button {
                    viewModel.addScore(excercise: selectedExcercise)
                    viewModel.newScoreIsActive.toggle()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.title2)
                }
                .foregroundColor(.white)
            }.padding()
        }
    }
}

//struct NewScore_Previews: PreviewProvider {
//    static var previews: some View {
//        NewScore()
//    }
//}
