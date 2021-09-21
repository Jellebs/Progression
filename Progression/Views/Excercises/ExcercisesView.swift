//
//  Excercises.swift
//  Progression
//
//  Created by Jesper Bertelsen on 06/09/2021.
//

import Foundation
import SwiftUI

struct ExcercisesView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                TopBar {
                    Button {
                        viewModel.newExcerciseIsActive.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(viewModel.excercises, id: \.id) { excercise in
                        ExcerciseCell(excercise: excercise)
                    }
                }
                Spacer()
            }
            .blur(radius: checkForInteractions() ? 3 : 0)
            .padding()
            if viewModel.newExcerciseIsActive {
                InteractionView(isActive: $viewModel.newExcerciseIsActive) {
                    NewExcercise()
                }
            }
            if viewModel.detailViewIsActive {
                ScoreDetails()
            }
        }
    }
    func checkForInteractions() -> Bool {
        if viewModel.newExcerciseIsActive || viewModel.detailViewIsActive {
            return true
        } else {
            return false
        }
    }
}
