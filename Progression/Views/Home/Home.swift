//
//  Home.swift
//  Progression
//
//  Created by Jesper Bertelsen on 26/08/2021.
//

import SwiftUI

struct Home: View {
    
    var currentDate: Date = Date()
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = .current
        let prefLanguage = Locale.preferredLanguages[0]
        formatter.locale = Locale(identifier: prefLanguage)
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter
    } ()
    
    @EnvironmentObject var viewModel: ViewModel 
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    TopBar { viewModel.newScoreIsActive.toggle() }
                    Text("\(dateFormatter.string(from: currentDate).capitalized)")
                        .foregroundColor(.primary)
                }.primaryColorSetting()
                .padding()
                ScrollView(.vertical, showsIndicators: false) {
                    if !viewModel.hasConfigured() {
                        IntroductionCell().padding()
                    }
                    VStack(spacing: 40) {
                        ForEach(viewModel.scores, id: \.id) { score in
                           ScoreCell(colorTheme: .black)
                                .frame(height: 170)
                                .environmentObject(score)
                        }
                        .frame(maxWidth: .infinity)
                    }
                 }
                 Spacer()
            }
            .blur(radius: viewModel.newScoreIsActive ? 3 : 0)
            if viewModel.newScoreIsActive {
                InteractionView(isActive: $viewModel.newScoreIsActive) {
                    NewScore(selectedExercise: viewModel.exercises.first)
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
