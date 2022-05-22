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
                    .blur(radius: viewModel.checkForExerciseInteractions() ? 3 : 0)
                    .padding()
                ScrollView(.vertical, showsIndicators: false) {
                    if viewModel.exercises.count != 0 {
                        VStack(spacing: 10) {
                            ForEach(viewModel.exercises, id: \.id) { excercise in
                                ExerciseCell(exercise: excercise)
                                    .blur(radius: viewModel.checkForExerciseInteractions() ? 3 : 0)
                            }
                        }
                    } else {
                        IntroductionCell()
                    }
                    
                }
                Spacer()
            }
            if viewModel.newExerciseIsActive {
                InteractionView(isActive: $viewModel.newExerciseIsActive) {
                    NewExercise()
                }
            }
            if viewModel.detailViewIsActive {
                ScoreDetails()
            }
            if viewModel.exerciseDeletionViewIsActive {
                Exercise_deletion(onConfirm: { viewModel.deleteExercise() }, onDeny: {}, isActive: $viewModel.exerciseDeletionViewIsActive)
            }
        }
    }
    
}
