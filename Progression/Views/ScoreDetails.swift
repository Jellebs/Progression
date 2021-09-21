//
//  ScoreDetails.swift
//  Progression
//
//  Created by Jesper Bertelsen on 21/09/2021.
//

import SwiftUI

struct ScoreDetails: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        InteractionView(isActive: $viewModel.detailViewIsActive) {
            VStack {
                ScoreCell_MainView(score: $viewModel.detailedScore, colorTheme: .white)
            }.padding()
            .onChange(of: viewModel.detailViewIsActive) { _ in
                viewModel.saveScore(score: viewModel.detailedScore)
            }
        }
    }
}

struct ScoreDetails_Previews: PreviewProvider {
    static var previews: some View {
        ScoreDetails()
    }
}
