//
//  NewActivity.swift
//  Progression
//
//  Created by Jesper Bertelsen on 27/08/2021.
//

import SwiftUI

struct NewExcercise: View {
    @State var excerciseName: String = ""

    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        VStack {
            Text("Give the excercise a name")
                .font(.title2)
            HStack {
                CustomTextField(text: $excerciseName, placeholderColor: .white.opacity(0.8), placeholderText: "Excercise name")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                Spacer()
                Button {
                    viewModel.addExcercise(name: excerciseName)
                    viewModel.newExcerciseIsActive.toggle()

                } label: {
                    Image(systemName: "checkmark.square")
                        .font(.title3)
                }

            }
            .padding()
        }.foregroundColor(.white)
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
        NewExcercise()
    }
}
