//
//  DeciderView.swift
//  Progression
//
//  Created by Jesper Bertelsen on 08/09/2021.
//

import SwiftUI

struct DeciderView: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        ZStack {
            if viewModel.excerciseViewIsActive {
                ExcercisesView()
            } else {
                Home()
            }
        }
    }
}

struct DeciderView_Previews: PreviewProvider {
    static var previews: some View {
        DeciderView()
    }
}
