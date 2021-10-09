//
//  NewActivity.swift
//  Progression
//
//  Created by Jesper Bertelsen on 27/08/2021.
//

import SwiftUI

struct NewExercise: View {
    @State var exerciseName: String = ""

    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        VStack {
            Text("Give the exercise a name")
                .font(.title2)
            HStack {
                CustomTextField(text: $exerciseName, placeholderColor: .black.opacity(0.8), placeholderText: "Exercise name")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                Spacer()
                Button {
                    viewModel.addExcercise(name: exerciseName)
                    viewModel.newExerciseIsActive.toggle()
                } label: {
                    Image(systemName: "checkmark.square")
                        .font(.title3)
                }

            }
            .padding()
        }.foregroundColor(.black)
    }
}


struct CustomTextField: View {
    @Binding var text: String
    var placeholderColor: Color
    var placeholderText: String

    var body: some View {
        ZStack {
            if text.isEmpty { Text(placeholderText).font(.title3) .foregroundColor(placeholderColor)
            }
            TextField(placeholderText, text: $text)
                .font(.title3)
        }

    }

}
struct NewActivity_Previews: PreviewProvider {
    static var previews: some View {
        NewExercise()
    }
}
