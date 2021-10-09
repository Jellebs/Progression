//
//  IntroductionCell.swift
//  Progression
//
//  Created by Jesper Bertelsen on 09/10/2021.
//

import SwiftUI

struct IntroductionCell: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        VStack {
            if viewModel.exerciseViewIsActive {
                Text("Start by adding an new exercise")
                    
            } else {
                Text("Start by adding a new score")
            }
        }.frame(maxWidth: .infinity, minHeight: 100, maxHeight: 100) .font(.title3).multilineTextAlignment(.leading).background(RoundedRectangle(cornerRadius: 8).secondaryColorSetting())
    }
}

struct IntroductionCell_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionCell()
    }
}
