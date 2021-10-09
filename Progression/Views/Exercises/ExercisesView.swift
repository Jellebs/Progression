//
//  Excercises.swift
//  Progression
//
//  Created by Jesper Bertelsen on 06/09/2021.
//

import Foundation
import SwiftUI

struct ExercisesView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                TopBar { viewModel.newExerciseIsActive.toggle() }
                    .primaryColorSetting()
                ScrollView(.vertical, showsIndicators: false) {
                    if viewModel.exercises.count != 0 {
                        ForEach(viewModel.exercises, id: \.id) { excercise in
                            ExerciseCell(excercise: excercise)
                        }
                    } else {
                        IntroductionCell()
                    }
                    
                }
                Spacer()
            }
            .blur(radius: checkForInteractions() ? 3 : 0)
            .padding()
            if viewModel.newExerciseIsActive {
                InteractionView(isActive: $viewModel.newExerciseIsActive) {
                    NewExercise()
                }
            }
            if viewModel.detailViewIsActive {
                ScoreDetails()
            }
        }
    }
    func checkForInteractions() -> Bool {
        if viewModel.newExerciseIsActive || viewModel.detailViewIsActive {
            return true
        } else {
            return false
        }
    }
}
